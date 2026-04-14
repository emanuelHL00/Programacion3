defmodule Punto5 do
  def main do
    vuelos = [
      %{codigo: "A1", disponible: true},
      %{codigo: "B2", disponible: false},
      %{codigo: "C3", disponible: true}
      ]

    codigos_disponibles(vuelos)

  end

  def codigos_disponibles(vuelos) do
      vuelos
      |>Enum.filter(fn vuelo -> vuelo.disponible end)
      |>Enum.map(fn vuelo -> vuelo.codigo end)
      |>IO.inspect()
    end

end

Punto5.main()
