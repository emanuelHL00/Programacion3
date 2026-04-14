defmodule Suma do
  def main do
    n=5
    IO.puts(sumar(n))
  end

  def sumar(n) do
    sumar(n,0)
  end

  defp sumar(1,acum) do
    acum + 1
  end

  defp sumar(n,acum) do
    sumar(n-1,acum+n)
  end

end

Suma.main()
