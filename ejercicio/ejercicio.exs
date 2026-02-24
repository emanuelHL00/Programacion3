defmodule Ejercicio do

  def validar_acceso(nombre, edad, credencial_valida, intentos_fallidos) do
    unless credencial_valida do
      {:error, "Acceso denegado, credenciales inválidas"}

    else
      if edad < 18 do
        {:error, "Acceso denegado, por no ser mayor de edad"}

      else
        if intentos_fallidos >= 3 do
          {:error, "Acceso denegado, número de intentos excedidos, cuenta bloqueada"}

        else
          {:ok, "Acceso aprobado"}
        end
      end
    end
  end

  def main do
    nombre =
      "Ingrese el nombre de usuario: "
      |> Util.ingresar(:texto)

    edad =
      "Ingrese la edad del usuario: "
      |> Util.ingresar(:entero)

    credencial_valida =
      IO.gets("¿Usted tiene credenciales válidas? (si/no): ")
      |> String.trim()
      |> String.downcase()
      |> case do
        "si" -> true
        "no" -> false
        _ ->
          IO.puts("Entrada inválida, credenciales invalidas")
          false
      end

    intentos_fallidos =
      "¿Cuántos intentos fallidos llevas?: "
      |> Util.ingresar(:entero)

    resultado = validar_acceso(nombre, edad, credencial_valida, intentos_fallidos)
    IO.inspect(resultado)
  end
end

Ejercicio.main()
