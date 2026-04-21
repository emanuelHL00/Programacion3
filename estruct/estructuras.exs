defmodule Estructuras do
  def main do
    "\nIngrese los datos del cliente: "
    |> Cliente.ingresar(:clientes)
    |> Cliente.escribir_csv("clientes.csv")
  end



  defp crear_lista_clientes() do
    [
      Cliente.crear("Ana", 16, 1.70),
      Cliente.crear("juan", 20, 1.72),
      Cliente.crear("diana", 41, 1.71),
      Cliente.crear("julian", 51, 1.72),
      Cliente.crear("isabella", 6, 1.00),
      Cliente.crear("sara", 8, 1.30)
    ]
  end

  defp filtrar_datos_interes(datos) do
    datos
    |>Enum.filter(fn (cliente) -> cliente.edad < 21 end)
  end

  defp generar_mensaje(cliente) do
    altura = cliente.altura |> Float.round(2)

    "Hola #{cliente.nombre}, tu edad es de #{cliente.edad} años y tu altura de #{cliente.altura}"
  end
end

Estructuras.main()
