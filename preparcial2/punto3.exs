defmodule Punto3 do

  def main do
    IO.puts("Pruebas:")

    IO.puts(perfecto?(6))
    IO.puts(perfecto?(28))
    IO.puts(perfecto?(8))   
  end

  def perfecto?(n) do
    suma_divisores(n, 1, 0) == n
  end

  defp suma_divisores(n, i, acc) when i == n do
    acc
  end

  defp suma_divisores(n, i, acc) do
    if rem(n, i) == 0 do
      suma_divisores(n, i + 1, acc + i)
    else
      suma_divisores(n, i + 1, acc)
    end
  end

end

Punto3.main()
