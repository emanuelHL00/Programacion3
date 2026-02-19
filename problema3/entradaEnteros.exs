defmodule EntradaEnteros do
  def main do

    valor_total = "Ingrese el valor total de la factura: "
    |> Util.ingresar(:entero)

    valor_entregado = "Ingrese el valor entregado: "
    |> Util.ingresar(:entero)

    calcular_devuelta(valor_total, valor_entregado)
    |> generar_mensaje
    |> Util.mostrar_mensaje

  end

  defp calcular_devuelta(valor_pago, valor_total) do
    valor_total - valor_pago
  end

  defp generar_mensaje(devuelta) do
    "El valor de devuelta es $ #{devuelta}"
  end
end

EntradaEnteros.main()
