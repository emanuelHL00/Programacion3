defmodule Punto2 do

  def main do
    IO.puts("Pruebas:")

    IO.puts(potencia?(16, 2))
    IO.puts(potencia?(27, 3))
    IO.puts(potencia?(50, 10))
    IO.puts(potencia?(7, 2))
  end

  def potencia?(n, b) when n == 1, do: true
  def potencia?(n, b) when n < b or b <= 1, do: false

  def potencia?(n, b) do
    if rem(n, b) == 0 do
      potencia?(div(n, b), b)
    else
      false
    end
  end

end

Punto2.main()
