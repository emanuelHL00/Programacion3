defmodule DiagonalSecundaria do
  def suma(matriz), do: suma(matriz, length(matriz) - 1)

  defp suma([], _), do: 0

  defp suma([fila | resto], i) do
    Enum.at(fila, i) + suma(resto, i - 1)
  end
end

# Prueba
IO.puts DiagonalSecundaria.suma([[1,2,3],[4,5,6],[7,8,9]])
