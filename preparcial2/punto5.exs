defmodule Punto5 do

  def main do
    IO.puts(reversible?(36))  
    IO.puts(reversible?(12))
    IO.puts(reversible?(10))
    IO.puts(reversible?(101))
  end


  def reversible?(n) when n <= 0, do: false
  def reversible?(n) when rem(n, 10) == 0, do: false

  def reversible?(n) do
    invertido = invertir(n, 0)
    suma = n + invertido
    todos_impares?(suma)
  end


  defp invertir(0, acc), do: acc

  defp invertir(n, acc) do
    invertir(div(n, 10), acc * 10 + rem(n, 10))
  end


  defp todos_impares?(0), do: true

  defp todos_impares?(n) do
    dig = rem(n, 10)

    if rem(dig, 2) == 0 do
      false
    else
      todos_impares?(div(n, 10))
    end
  end

end

Punto5.main()
