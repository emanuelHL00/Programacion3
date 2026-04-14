defmodule Punto4 do
  def main do
    lista = [1,2,3,4,5]
    nueva_lista = Enum.map(lista, fn x -> x*2 end)
    IO.inspect(nueva_lista)

    [1,2,3,4,5,6]
    |>Enum.filter(fn x -> rem(x,2) == 0 end)
    |>Enum.map(fn x -> x + 1 end)
    |>IO.inspect()

    lista_decimos = [10,20,30,40]

    suma =
      lista_decimos
      |>Enum.reduce(0,fn x, acc -> acc + x end)

    promedio = suma/length(lista_decimos)
    IO.inspect(promedio)

  end

end

Punto4.main()
