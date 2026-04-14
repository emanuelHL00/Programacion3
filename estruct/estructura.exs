defmodule Estructuras do
  def main do
    "ingrese los datos del cliente: "
    |>Cliente.ingresar()
    |>generar_mensaje()
    |>Util.mostrar_mensaje()
  end

  def generar_mensaje(cliente) do
    altura = cliente.altura |> Float.round(2)
    "Hola #{cliente.nombre}, tu edad es #{cliente.edad} años y tu altura es de #{altura} cm\n"

  end
end

Estructuras.main()
