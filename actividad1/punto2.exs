defmodule Parqueadero do
  def calcular_tarifa do
    horas = Util.ingresar("Ingrese el numero de horas que estuvo en el parqueadero: ", :entero)
    tipo_cliente = Util.ingresar("ingresar que tipo de cliente es, 1 = frecuente, 2 = regular: ", :entero)
    tipo_vehiculo = Util.ingresar("Ingrese que tipo de vehiculo es, 1 = electrico, 2 = convencional: ",:entero)
    dia = Util.ingresar("ingrese 1 si el dia es fin de semana o 2 para entre semana", :entero)

    tarifa_base = calcular_tarifa(horas)

    descuento_cliente = if tipo_cliente == 1, do: 0.15, else: 0.0
    descuento_vehiculo = if tipo_vehiculo == 1, do: 0.20, else: 0.0
    descuento_dia = if dia == 1, do: 0.10, else: 0.0

    total_descuento = descuento_cliente + descuento_vehiculo + descuento_dia
    valor_descuento = tarifa_base * total_descuento
    valor_final = tarifa_base - valor_descuento

    resultado = {tarifa_base, valor_final}

    Util.mostrar_mensaje("\n===== DESGLOSE DE PARQUEADERO =====")
    Util.mostrar_mensaje("Horas:            #{horas}")
    Util.mostrar_mensaje("Tarifa base:      $#{tarifa_base}")
    Util.mostrar_mensaje("Descuento total:  #{total_descuento * 100}%  (-$#{valor_descuento})")
    Util.mostrar_mensaje("TOTAL A PAGAR:    $#{valor_final}")
  end

  defp calcular_tarifa(horas) when horas > 8, do: 18000

  defp calcular_tarifa(horas) do
    cond do
       horas <= 2 -> 3000
       horas <= 5 -> 3000 + (horas - 2) * 2500
       horas <= 8 -> 3000  + 3 * 2500 + (horas - 5) * 2000
    end
  end
end

Parqueadero.calcular_tarifa()
