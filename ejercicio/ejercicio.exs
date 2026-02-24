defmodule Ejercicio do
  alias ElixirLS.LanguageServer.Plugins.Util
  def main do
    nombre =
    "ingrese el nombre de ususario: "
    |> Util.ingresar(:texto)

    edad =
    "Ingrese la edad del usaurio: "
    |> Util.ingresar(:entero)

    credencial_valida =
    "Usted tiene credenciales validas(si/no): "
    |>IO.gets()
    |>String.trim()
    |>String.downcase()
    |>case do
      "si" -> true
      "no" -> false
    end

    intentos_fallidos =
    "Cuantos intentos de registro fallidos llevas? "
    |>Util.ingresar(:entero)
    |>String.trim()
    |> String.to_integer()


    def validar_acceso(nombre, edad, credencial_valida, intentos_fallidos) do
      unless credencial_valida do
        {:error, "Acceso denegado, credenciales denegadas"}

        else
          if edad < 18 do
           {:error, "Acceso denegado, por no ser mayor de edad"}

          else
            if intentos_fallidos >= 3 do
          {:error, "Acceso denegado, numero de intentos excedidos, cuenta bloqueada"}

            else
              {:ok, "acceso aprobado"}



          end
        end
      end
  end

  resultado = validar_acceso(nombre, edad, credenciales_validas, intentos_fallidos)
  IO.inspect(resultado)
  
  end

  Ejercicio.main()

end
