defmodule Punto3 do
  def main do
    noches = Util.ingresar("Ingrese numero de noches: ", :entero)
    tipo = Util.ingresar("Tipo (frecuente/corporativo/ocasional): ", :texto)
    temporada = Util.ingresar("Temporada (1 alta / 2 baja): ", :entero)

    resultado = calcular_reserva(noches, String.to_atom(tipo), temporada)

    case resultado do
      {:error, msg} ->
        IO.puts(msg)

      {:ok, tarifa, subtotal, descuento, recargo, total} ->
        IO.puts("Tarifa por noche: #{tarifa}")
        IO.puts("Subtotal: #{subtotal}")
        IO.puts("Descuento: #{descuento}")
        IO.puts("Recargo: #{recargo}")
        IO.puts("Total: #{total}")
    end
  end

  # descuentos
  def descuento(:frecuente), do: 0.20
  def descuento(:corporativo), do: 0.15
  def descuento(:ocasional), do: 0.0

  # tarifas
  def tarifa_base(n) when n <= 2, do: 120000
  def tarifa_base(n) when n <= 5, do: 100000
  def tarifa_base(_), do: 85000

  # función principal
  def calcular_reserva(noches, tipo, temporada) do
    cond do
      noches <= 0 ->
        {:error, "Noches inválidas"}

      temporada != 1 and temporada != 2 ->
        {:error, "Temporada inválida"}

      true ->
        tarifa = tarifa_base(noches)
        subtotal = tarifa * noches

        valor_desc = subtotal * descuento(tipo)
        total_desc = subtotal - valor_desc

        recargo =
          cond do
            temporada == 1 -> total_desc * 0.25
            true -> 0
          end

        total = total_desc + recargo

        {:ok, tarifa, subtotal, valor_desc, recargo, total}
    end
  end
end

Punto3.main()
