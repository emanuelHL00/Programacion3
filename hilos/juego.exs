defmodule Juego do

  def main do
    IO.puts("Iniciando juego...\n")

    jugadores = ["Ana", "Luis", "Carlos", "Sofía"]

    tareas =
      Enum.map(jugadores, fn jugador ->
        Task.async(fn -> jugar(jugador) end)
      end)

    resultados =
      Enum.map(tareas, fn tarea ->
        Task.await(tarea, 2000)
      end)

    IO.puts("\nResultados del juego:")
    IO.inspect(resultados)
  end

  def jugar(jugador) do
    tiempo = :rand.uniform(1500)
    Process.sleep(tiempo)

    puntos = :rand.uniform(100)

    "#{jugador} consiguió #{puntos} puntos en #{tiempo} ms"
  end

end

Juego.main()
