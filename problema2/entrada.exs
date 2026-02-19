defmodule EntradaDatos do
  def main do
    "Ingresar el nombre del empleado"
    |>Util.ingresar(:texto)
    |>generar_mensaje()
    |>Util.mostrar_mensaje_java()
  end


  defp generar_mensaje(nombre) do
    "Bienvenido #{nombre} a la empresa once ltda"
  end
end

EntradaDatos.main()
