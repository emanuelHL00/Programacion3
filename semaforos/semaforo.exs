defmodule Parqueadero do
  use GenServer

  # Inicia el parqueadero con N cupos
  def start_link(cupos) do
    GenServer.start_link(__MODULE__, cupos, name: __MODULE__)
  end

  # Entrar al parqueadero (bloquea si está lleno)
  def entrar(carro) do
    IO.puts("🚗  #{carro} quiere entrar...")
    GenServer.call(__MODULE__, {:entrar, carro}, :infinity)
  end

  # Salir del parqueadero
  def salir(carro) do
    GenServer.cast(__MODULE__, {:salir, carro})
  end

  # --- Callbacks internos ---

  def init(cupos) do
    IO.puts("🏢  Parqueadero abierto con #{cupos} cupos.\n")
    {:ok, %{cupos: cupos, espera: :queue.new()}}
  end

  # Hay cupo → entra de inmediato
  def handle_call({:entrar, carro}, _from, %{cupos: n} = state) when n > 0 do
    IO.puts("✅  #{carro} ENTRÓ. Cupos libres: #{n - 1}")
    {:reply, :ok, %{state | cupos: n - 1}}
  end

  # No hay cupo → queda esperando
  def handle_call({:entrar, carro}, from, state) do
    IO.puts("⏳  #{carro} ESPERA (parqueadero lleno)")
    {:noreply, %{state | espera: :queue.in({from, carro}, state.espera)}}
  end

  # Sale un carro → si hay alguien esperando, lo deja entrar
  def handle_cast({:salir, carro}, state) do
    IO.puts("🚪  #{carro} SALIÓ")
    case :queue.out(state.espera) do
      {{:value, {from, siguiente}}, resto} ->
        IO.puts("✅  #{siguiente} ENTRÓ (estaba esperando)")
        GenServer.reply(from, :ok)
        {:noreply, %{state | espera: resto}}
      {:empty, _} ->
        {:noreply, %{state | cupos: state.cupos + 1}}
    end
  end
end

defmodule Main do
  def run do
    {:ok, _} = Parqueadero.start_link(2)  # Solo 2 cupos

    # Lanzar 5 carros concurrentes
    pids = for n <- 1..5 do
      spawn(fn ->
        nombre = "Carro-#{n}"
        Parqueadero.entrar(nombre)
        Process.sleep(:rand.uniform(3) * 1000)  # Tiempo estacionado
        Parqueadero.salir(nombre)
      end)
    end

    # Esperar a que todos terminen
    pids |> Enum.map(&Process.monitor/1) |> Enum.each(fn ref ->
      receive do {:DOWN, ^ref, :process, _, _} -> :ok end
    end)

    IO.puts("\n🏁  Todos los carros terminaron.")
  end
end

Main.run()
