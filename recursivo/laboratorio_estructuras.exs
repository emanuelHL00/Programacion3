defmodule Aerolinea do
  def main do
   vuelos = [
  %{
    codigo: "AV201",
    aerolinea: "Avianca",
    origen: "BOG",
    destino: "MDE",
    duracion: 45,
    precio: 180_000,
    pasajeros: 120,
    disponible: true
  },
  %{
    codigo: "LA305",
    aerolinea: "Latam",
    origen: "BOG",
    destino: "CLO",
    duracion: 55,
    precio: 210_000,
    pasajeros: 98,
    disponible: true
  },
  %{
    codigo: "AV410",
    aerolinea: "Avianca",
    origen: "MDE",
    destino: "CTG",
    duracion: 75,
    precio: 320_000,
    pasajeros: 134,
    disponible: false
  },
  %{
    codigo: "VV102",
    aerolinea: "Viva Air",
    origen: "BOG",
    destino: "BAQ",
    duracion: 90,
    precio: 145_000,
    pasajeros: 180,
    disponible: true  },
  %{
    codigo: "LA512",
    aerolinea: "Latam",
    origen: "CLO",
    destino: "CTG",
    duracion: 110,
    precio: 480_000,
    pasajeros: 76,
    disponible: false
  },
  %{
    codigo: "AV330",
    aerolinea: "Avianca",
    origen: "BOG",
    destino: "CTG",
    duracion: 135,
    precio: 520_000,
    pasajeros: 155,
    disponible: true
  },
  %{
    codigo: "VV215",
    aerolinea: "Viva Air",
    origen: "MDE",
    destino: "BOG",
    duracion: 50,
    precio: 130_000,
    pasajeros: 190,
    disponible: true
  },
  %{
    codigo: "LA620",
    aerolinea: "Latam",
    origen: "BOG",
    destino: "MDE",
    duracion: 145,
    precio: 390_000,
    pasajeros: 112,
    disponible: true
  },
  %{
    codigo: "AV505",
    aerolinea: "Avianca",
    origen: "CTG",
    destino: "BOG",
    duracion: 120,
    precio: 440_000,
    pasajeros: 143,
    disponible: false
  },
  %{
    codigo: "VV340",
    aerolinea: "Viva Air",
    origen: "BAQ",
    destino: "BOG",
    duracion: 85,
    precio: 160_000,
    pasajeros: 175,
    disponible: true
  }
]


codigo_vuelos_alfabeticamente(vuelos)
pasajeros_por_aerolinea(vuelos)
formato_vuelos(vuelos)
vuelos_descuento(vuelos)
aerolineas_con_todas_categorias(vuelos)
rutas_mas_rentables(vuelos)


  end

  def codigo_vuelos_alfabeticamente(vuelos) do
    resultado =
      vuelos
      |> Enum.filter(&(&1.disponible == true))
      |> Enum.map(&(&1.codigo))
      |> Enum.sort()
      IO.inspect(resultado)
  end

  def pasajeros_por_aerolinea(vuelos) do
    vuelos
    |> Enum.group_by(&(&1.aerolinea))
    |> Enum.map(fn {aerolinea, lista_vuelos} ->
      total_pasajeros =
        lista_vuelos
        |> Enum.reduce(0, fn vuelo, acc -> acc + vuelo.pasajeros end)

      {aerolinea, total_pasajeros}
    end)
  |> IO.inspect()
  end

  def formato_vuelos(vuelos) do
    vuelos
    |> Enum.map(fn vuelo ->
      horas = div(vuelo.duracion, 60)
      minutos = rem(vuelo.duracion, 60)

      minutos_texto =
        if minutos < 10 do
          "0#{minutos}"
        else
          "#{minutos}"
        end

      "#{vuelo.codigo} — #{vuelo.origen} → #{vuelo.destino}: #{horas}h #{minutos_texto}m"
    end)
    |> IO.inspect()
  end

  def vuelos_descuento(vuelos) do
    vuelos
    |> Enum.filter(&(&1.precio < 400000))
    |> Enum.map(fn vuelo ->
      precio_final = vuelo.precio * 0.9
      {
        vuelo.codigo,
        "#{vuelo.origen}-#{vuelo.destino}",
        precio_final
      }
    end)
    |> Enum.sort_by(fn {_, _, precio} -> precio end)
    |> IO.inspect()
  end

  def clasificar(duracion) do
    cond do
      duracion < 60 -> :corto
      duracion <= 120 -> :medio
      true -> :largo
    end
  end

  def aerolineas_con_todas_categorias(vuelos) do
    vuelos
    |> Enum.group_by(&(&1.aerolinea))
    |> Enum.filter(fn {_, lista_vuelos} ->
      categorias =
        lista_vuelos
        |> Enum.map(fn vuelo -> clasificar(vuelo.duracion) end)

      Enum.member?(categorias, :corto) and
      Enum.member?(categorias, :medio) and
      Enum.member?(categorias, :largo)
    end)
    |> Enum.map(fn {aerolinea, _} -> aerolinea end)
    |> IO.inspect()
  end

  def rutas_mas_rentables(vuelos) do
    vuelos
    |> Enum.filter(& &1.disponible)
    |> Enum.map(&{"#{&1.origen} → #{&1.destino}", &1.precio * &1.pasajeros})
    |> Enum.sort_by(fn {_, ingreso} -> ingreso end, :desc)
    |> Enum.take(3)
    |> IO.inspect()
  end







end

Aerolinea.main()
