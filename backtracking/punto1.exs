defmodule Diagonal do
  def recorrer(matriz), do: recorrer(matriz, 0)

  defp recorrer([], _), do: []

  defp recorrer([fila | resto], i) do
    [Enum.at(fila, i) | recorrer(resto, i + 1)]
  end
end

IO.inspect Diagonal.recorrer([[1,2,3],[4,5,6],[7,8,9]])
