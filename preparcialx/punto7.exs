defmodule Punto7 do
  def main do

    lista = [1,2,3,4,0,9,76,5]
    IO.puts(sumar_lista(lista))
    IO.puts(contar_elementos(lista))
    IO.puts(mayor(lista))

  end

  def sumar_lista([]), do: 0

  def sumar_lista([h | t]) do
    h + sumar_lista(t)
  end

  def contar_elementos([]), do: 0

  def contar_elementos([_| t]) do
    1 + contar_elementos(t)
  end

  def mayor([h]), do: h

  def mayor([h | t]) do
    resto = mayor(t)
    if h > resto do
      h
    else
      resto
    end
  end


end

Punto7.main()
