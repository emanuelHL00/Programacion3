defmodule Punto6 do
  def main do
    vuelos =
    [
      %{aerolinea: "Avianca", pasajeros: 100},
      %{aerolinea: "Avianca", pasajeros: 50},
      %{aerolinea: "Latam", pasajeros: 80}
    ]

    IO.inspect(pasajeros_por_aerolinea(vuelos))

  def pasajeros_por_aerolinea(vuelos) do
    vuelos
    |> Enum.group_by(fn vuelo -> vuelo.aerolinea end)
    |> Enum.map(fn {aerolinea, lista_vuelos} ->
      total =
        lista_vuelos
        |> Enum.reduce(0, fn vuelo, acc -> acc + vuelo.pasajeros end)

      {aerolinea, total}
    end)
  end
  


  end

end

Punto6.main()
