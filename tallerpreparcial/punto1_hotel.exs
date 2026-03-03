defmodule Hotel do


  def tarifa_base(noches) when noches <= 2, do: 120_000
  def tarifa_base(noches) when noches <= 5, do: 100_000
  def tarifa_base(_noches),                 do:  85_000


  def descuento(:frecuente),   do: 0.20
  def descuento(:corporativo), do: 0.15
  def descuento(:ocasional),   do: 0.00
  def descuento(_),            do: :error

  def recargo(temporada) do
    cond do
      temporada == 1 -> 0.25
      temporada == 2 -> 0.00
      true           -> :error
    end
  end

  def calcular(noches, tipo_cliente, temporada) do
    tarifa      = tarifa_base(noches)
    desc_rate   = descuento(tipo_cliente)
    recargo_rate = recargo(temporada)

    cond do
      noches <= 0         -> {:error, "El número de noches debe ser mayor a 0"}
      desc_rate == :error -> {:error, "Tipo de cliente inválido. Use :frecuente, :corporativo u :ocasional"}
      recargo_rate == :error -> {:error, "Temporada inválida. Use 1 (alta) o 2 (baja)"}
      true ->
        subtotal      = tarifa * noches
        valor_descuento = subtotal * desc_rate
        valor_recargo   = (subtotal - valor_descuento) * recargo_rate
        total           = subtotal - valor_descuento + valor_recargo

        {:ok, tarifa, subtotal, valor_descuento, valor_recargo, total}
    end
  end


  def mostrar(noches, tipo_cliente, temporada) do
    case calcular(noches, tipo_cliente, temporada) do
      {:ok, tarifa, subtotal, descuento, recargo, total} ->
        IO.puts("       RESUMEN DE RESERVA - HOTEL")
        IO.puts("Tarifa base por noche : $#{formato(tarifa)}")
        IO.puts("Número de noches      : #{noches}")
        IO.puts("Subtotal              : $#{formato(subtotal)}")
        IO.puts("Descuento aplicado    : -$#{formato(descuento)}")
        IO.puts("Recargo temporada     : +$#{formato(recargo)}")
        IO.puts("--------------------------------------------")
        IO.puts("TOTAL A PAGAR         : $#{formato(total)}")

      {:error, mensaje} ->
        IO.puts("Error: #{mensaje}")
    end
  end

  defp formato(numero) do
    numero
    |> round()
    |> Integer.to_string()
  end

end



IO.puts("\n=== SISTEMA DE RESERVAS DEL HOTEL ===\n")

noches = Util.ingresar("Ingrese el número de noches: ", :entero)

IO.puts("Tipos de cliente: frecuente | corporativo | ocasional")
tipo_texto = Util.ingresar("Ingrese el tipo de cliente: ", :texto)

tipo_cliente = String.to_atom(tipo_texto)

IO.puts("Temporada: 1 = Alta  |  2 = Baja")
temporada = Util.ingresar("Ingrese la temporada (1 o 2): ", :entero)

IO.puts("")
Hotel.mostrar(noches, tipo_cliente, temporada)
