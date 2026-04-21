defmodule Punto4 do

  def main do
    lista = ["hola", "computador", "sol", "programacion"]

    IO.puts("Cadena más larga:")
    IO.puts(mas_larga(lista))
  end

  def mas_larga([h]), do: h

  def mas_larga([h | t]) do
    resto = mas_larga(t)

    if String.length(h) > String.length(resto) do
      h
    else
      resto
    end
  end

end

Punto4.main()
