defmodule Punto4 do

  def main do
    lista = ["hola", "computador", "sol", "programacion"]

    IO.puts("Cadena más larga:")
    IO.puts(mas_larga(lista))
  end

  def mas_larga([h | t]) do
    buscar(t, h)
  end

  defp buscar([], mayor), do: mayor

  defp buscar([h | t], mayor) do
    if String.length(h) > String.length(mayor) do
      buscar(t, h)
    else
      buscar(t, mayor)
    end
  end

end

Punto4.main()
