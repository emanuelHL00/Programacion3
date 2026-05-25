Code.require_file("libro.exs")

defmodule Biblioteca do

  def guardar(lista) do

    encabezado = "id,titulo,autor,cantidad\n"

    contenido =

      Enum.map_join(lista, "\n", fn libro ->

        "#{libro.id},#{libro.titulo},#{libro.autor},#{libro.cantidad}"

      end)

    File.write("biblioteca.csv", encabezado <> contenido)

  end

  def loop(lista) do

    receive do

      {:agregar, libro} ->

        existe =

          Enum.find(lista, fn x ->
            x.id == libro.id
          end)

        if existe do

          nueva_lista =

            Enum.map(lista, fn x ->

              if x.id == libro.id do

                %{
                  x |
                  cantidad: x.cantidad + libro.cantidad
                }

              else

                x

              end

            end)

          loop(nueva_lista)

        else

          nueva_lista = [libro | lista]

          loop(nueva_lista)

        end

      {:prestar, id} ->

        libro =

          Enum.find(lista, fn x ->
            x.id == id
          end)

        if libro && libro.cantidad > 0 do

          nueva_lista =

            Enum.map(lista, fn x ->

              if x.id == id do

                %{
                  x |
                  cantidad: x.cantidad - 1
                }

              else

                x

              end

            end)

          loop(nueva_lista)

        else

          IO.puts("este libro no se puede prestar")

          loop(lista)

        end

      {:listar, pid} ->

        send(pid, lista)

        loop(lista)

      {:total, pid} ->

        total =

          Enum.reduce(lista, 0, fn libro, acc ->

            acc + libro.cantidad

          end)

        send(pid, total)

        loop(lista)

      :guardar ->

        guardar(lista)

        loop(lista)

      :vaciar ->

        loop([])

      :detener ->

        IO.puts("biblioteca detenida")

        :ok

    end

  end

  def main do

    pid = spawn(fn -> loop([]) end)

    libro1 = struct(Libro,
      id: 1,
      titulo: "El principito",
      autor: "Antoine",
      cantidad: 5
    )

    libro2 = struct(Libro,
      id: 2,
      titulo: "1984",
      autor: "George Orwell",
      cantidad: 3
    )

    libro3 = struct(Libro,
      id: 1,
      titulo: "El principito",
      autor: "Antoine",
      cantidad: 2
    )

    send(pid, {:agregar, libro1})

    send(pid, {:agregar, libro2})

    send(pid, {:agregar, libro3})

    send(pid, {:prestar, 1})

    send(pid, {:listar, self()})

    receive do

      lista ->
        IO.inspect(lista)

    end

    send(pid, {:total, self()})

    receive do

      total ->
        IO.puts("Total libros: #{total}")

    end

    send(pid, :guardar)

    send(pid, :detener)

    Process.sleep(1000)

  end

end

Biblioteca.main()
