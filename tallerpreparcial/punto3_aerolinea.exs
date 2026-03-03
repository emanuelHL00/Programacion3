defmodule Aerolinea do


  def tarifa_base(:bogota),   do: 180_000
  def tarifa_base(:medellin), do: 220_000
  def tarifa_base(:cartagena),do: 310_000
  def tarifa_base(:san_andres),do: 450_000
  def tarifa_base(_),          do: :error

  def maleta_obligatoria?(destino) when destino == :san_andres, do: true
  def maleta_obligatoria?(_destino), do: false

  def cargo_silla(true),  do: 15_000
  def cargo_silla(false), do: 0

  def cargo_maleta(true),  do: 45_000
  def cargo_maleta(false), do: 0

  def cargo_seguro(true),  do: 12_000
  def cargo_seguro(false), do: 0


  def calcular(destino, quiere_silla, quiere_maleta, quiere_seguro) do
    base = tarifa_base(destino)

    if base == :error do
      {:error, "Destino inválido. Use :bogota, :medellin, :cartagena o :san_andres"}
    else
      maleta_auto = maleta_obligatoria?(destino)
      maleta_final = maleta_auto or quiere_maleta

      costo_silla  = cargo_silla(quiere_silla)
      costo_maleta = cargo_maleta(maleta_final)
      costo_seguro = cargo_seguro(quiere_seguro)

      total = base + costo_silla + costo_maleta + costo_seguro

      {:ok, base, costo_silla, costo_maleta, costo_seguro, total, maleta_auto}
    end
  end


  def mostrar(destino, silla, maleta, seguro) do
    case calcular(destino, silla, maleta, seguro) do
      {:ok, base, c_silla, c_maleta, c_seguro, total, maleta_auto} ->
        IO.puts("       RESUMEN DE TIQUETE AÉREO")
        IO.puts("Destino               : #{destino}")
        IO.puts("Tarifa base           : $#{base}")
        IO.puts("Selección de silla    : $#{c_silla}")

        if maleta_auto do
          IO.puts("Maleta de bodega      : $#{c_maleta}  (obligatoria para este destino)")
        else
          IO.puts("Maleta de bodega      : $#{c_maleta}")
        end

        IO.puts("Seguro de viaje       : $#{c_seguro}")
        IO.puts("TOTAL A PAGAR         : $#{total}")

      {:error, mensaje} ->
        IO.puts("Error: #{mensaje}")
    end
  end

end


IO.puts("\n=== AEROLÍNEA ECONÓMICA - COMPRA DE TIQUETE ===\n")

IO.puts("Destinos disponibles: bogota | medellin | cartagena | san_andres")
destino_texto = Util.ingresar("Ingrese el destino: ", :texto)
destino = String.to_atom(destino_texto)

IO.puts("")
silla  = Util.ingresar("¿Desea selección de silla? (+$15.000)",:boolean)
maleta = Util.ingresar("¿Desea maleta de bodega?  (+$45.000)",:boolean)
seguro = Util.ingresar("¿Desea seguro de viaje?   (+$12.000)",:boolean)

IO.puts("")
Aerolinea.mostrar(destino, silla, maleta, seguro)
