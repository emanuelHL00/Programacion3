defmodule SumaMatriz do
  def suma([]), do: 0

  def suma([fila | resto]) do
    suma_lista(fila) + suma(resto)
  end

  defp suma_lista([]), do: 0

  defp suma_lista([x | xs]) do
    x + suma_lista(xs)
  end
end


IO.puts SumaMatriz.suma([[1,2],[3,4]])
