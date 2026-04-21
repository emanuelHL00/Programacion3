defmodule Punto11 do
  def main do
    vuelos = [
      %{codigo: "A1", pasajeros: 100},
      %{codigo: "B2", pasajeros: 50},
      %{codigo: "C3", pasajeros: 200},
      %{codigo: "D4", pasajeros: 80}
    ]

    IO.inspect(pasajeros_mas_80(vuelos))
    IO.puts(total_pasajeros(vuelos))
    IO.inspect(agrupar_vuelos(vuelos))
    IO.inspect(mayor_vuelo(vuelos))

  end

  def pasajeros_mas_80(vuelos) do
    vuelos
    |>Enum.filter(fn vuelo -> vuelo.pasajeros > 80 end)
    |>Enum.map(fn vuelo -> vuelo.codigo end)
  end

  def total_pasajeros(vuelos) do
    vuelos
    |>Enum.reduce(0, fn vuelo, acc -> acc + vuelo.pasajeros end)
  end

  def agrupar_vuelos(vuelos) do
    Enum.reduce(vuelos, %{mayores: [], menores: []}, fn vuelo, acc ->
      if vuelo.pasajeros > 100 do
        %{acc | mayores: [vuelo | acc.mayores]}
      else
        %{acc | menores: [vuelo | acc.menores]}
      end
    end)
  end

  def mayor_vuelo(vuelos) do
    [primero | resto] = vuelos

    Enum.reduce(resto, primero, fn vuelo, acc ->
      if vuelo.pasajeros > acc.pasajeros do
        vuelo
      else
        acc
      end
    end)
  end

end

Punto11.main()
