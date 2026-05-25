Code.require_file("item.exs")

defmodule Carrito do

  # =========================
  # INICIAR ACTOR
  # =========================
  def iniciar do

    items = cargar()

    spawn(fn ->
      loop(items)
    end)

  end

  # =========================
  # LOOP PRINCIPAL
  # =========================
  def loop(items) do

    receive do

      # =====================
      # AGREGAR ITEM
      # =====================
      {:agregar_item, item} ->

        existe =
          Enum.find(items, fn x ->
            x.id == item.id
          end)

        nuevos =
          if existe do

            Enum.map(items, fn x ->

              if x.id == item.id do

                %Item{
                  x |
                  cantidad: x.cantidad + item.cantidad
                }

              else
                x
              end

            end)

          else

            [item | items]

          end

        loop(nuevos)

      # =====================
      # QUITAR ITEM
      # =====================
      {:quitar_item, id} ->

        nuevos =
          Enum.filter(items, fn x ->
            x.id != id
          end)

        loop(nuevos)

      # =====================
      # TOTAL
      # =====================
      {:total, pid} ->

        total =
          Enum.reduce(items, 0, fn x, acc ->

            acc + (x.cantidad * x.precio)

          end)

        send(pid, total)

        loop(items)

      # =====================
      # LISTAR
      # =====================
      {:listar, pid} ->

        send(pid, items)

        loop(items)

      # =====================
      # GUARDAR CSV
      # =====================
      :guardar_carrito ->

        texto =
          "id,nombre,cantidad,precio\n" <>

          Enum.map_join(items, "\n", fn x ->

            "#{x.id},#{x.nombre},#{x.cantidad},#{x.precio}"

          end)

        File.write("carrito.csv", texto)

        loop(items)

      # =====================
      # VACIAR
      # =====================
      :vaciar ->

        File.write(
        "carrito.csv",
        "id,nombre,cantidad,precio\n"
        )

        loop([])

      # =====================
      # DETENER
      # =====================
      :detener ->

        :ok

    end

  end

  # =========================
  # CARGAR CSV
  # =========================
  def cargar do

    if File.exists?("carrito.csv") do

      {:ok, texto} = File.read("carrito.csv")

      lineas =
        String.split(texto, "\n", trim: true)

      datos =
        Enum.drop(lineas, 1)

      Enum.map(datos, fn x ->

        [id, nombre, cantidad, precio] =

          Enum.map(
            String.split(x, ","),
            fn dato ->
              String.trim(dato)
            end
          )

        %Item{
          id: String.to_integer(id),
          nombre: nombre,
          cantidad: String.to_integer(cantidad),
          precio: String.to_float(precio)
        }

      end)

    else

      []

    end

  end

  # =========================
  # MAIN
  # =========================
  def main do
    pid = iniciar()

item1 = %Item{
  id: 1,
  nombre: "Mouse",
  cantidad: 2,
  precio: 50.0
}

item2 = %Item{
  id: 2,
  nombre: "Teclado",
  cantidad: 1,
  precio: 120.0
}

# AGREGAR
send(pid, {:agregar_item, item1})
send(pid, {:agregar_item, item2})

# LISTAR
send(pid, {:listar, self()})

receive do
  msg ->
    IO.inspect(msg)
end

# TOTAL
send(pid, {:total, self()})

receive do
  msg ->
    IO.puts("TOTAL: #{msg}")
end

# GUARDAR
send(pid, :guardar_carrito)

# QUITAR ITEM
send(pid, {:quitar_item, 1})

# VACIAR

# DETENER
send(pid, :detener)



  end

end

# EJECUTAR MAIN
Carrito.main()
