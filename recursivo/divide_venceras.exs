defmodule Programa do
  def main do
    lista = [1,2,3,4,5,6,7]
    resultado = suma(lista)
    IO.puts(resultado)
  end

  def suma([]), do: 0
  def suma([x]), do: x

  def suma(lista) do
    mitad = div(length(lista), 2)
    {izq, der} = Enum.split(lista, mitad)
    suma(izq) + suma(der)
  end


end

Programa.main()
