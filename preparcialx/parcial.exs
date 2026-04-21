defmodule Parcial do
  def main do
    lista = [1,2,3,4]
    IO.puts(contar_pares(lista))

    digito = 123
    IO.puts(sumar_digitos(digito))

    vuelos = [
      %{codigo: "A1", pasajeros: 120},
      %{codigo: "B2", pasajeros: 80},
      %{codigo: "C3", pasajeros: 200},
      %{codigo: "D4", pasajeros: 50}
    ]

    IO.inspect(mas_100_pasajeros(vuelos))
    IO.inspect(menos_pasajeros(vuelos))

  end

  def contar_pares([]), do: 0
  def contar_pares([h | t]) do
    if rem(h,2) == 0 do
      1 + contar_pares(t)
    else
      contar_pares(t)
    end
  end

  def sumar_digitos(n), do: sumar_digitos(n,0)
  def sumar_digitos(0,acc), do: acc
  def sumar_digitos(n,acc) do
    digito = rem(n, 10)
    sumar_digitos(div(n,10), acc + digito)
  end

  def mas_100_pasajeros(vuelos) do
    vuelos
    |>Enum.filter(fn vuelo -> vuelo.pasajeros > 100 end)
    |>Enum.map(fn vuelo -> vuelo.codigo end)
  end

  def menos_pasajeros(vuelos) do
    [primero | resto] = vuelos

    Enum.reduce(resto, primero, fn vuelo, acc ->
      if vuelo.pasajeros < acc.pasajeros do
        vuelo
      else
        acc
      end
    end)

  end

end

Parcial.main()
