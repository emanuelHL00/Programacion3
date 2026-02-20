defmodule EntradaReales do
  def main do
    valor_producto =
      "Ingrese el valor del producto: "
      |>Util.ingresar(:entero)

    porcentaje_descuento =
      "ingrese el porcentaje del descuento: "
      |> ingresar(:real)

    valor_descuento = calcular_valor_descuento(valor_producto, porcentaje_descuento)
    valor_final = calcular_valor_final(valor_producto, valor_descuento)

    generar_mensaje(valor_descuento, valor_final)
    |> Util.mostrar_mensaje()


  end

end
