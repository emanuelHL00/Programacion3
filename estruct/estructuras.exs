defmodule Estructuras do
  def main do
    "\n ingrese los datos del cliente: "
    |>Cliente.ingresar(:clientes)
    |>Cliente.generar_mensaje_clientes(&generar_mensaje/1)
    |>Util.mostrar_mensaje()
  end

  def generar_mensaje(cliente) do
    altura = cliente.altura |> Float.round(2)
    "Hola #{cliente.nombre}, tu edad es #{cliente.edad} años y tu altura es de #{altura} cm\n"
  end
end

Estructuras.main()
