defmodule ValidadorUsuario do
  def validar do
    usuario = Util.ingresar("Ingresa nombre de usuario: ", :texto)

    resultado =
      []
      |> validar_longitud(usuario)
      |> validar_minusculas(usuario)
      |> validar_espacios(usuario)
      |> validar_especiales(usuario)
      |> validar_tiene_letra(usuario)
      |> construir_resultado()

    case resultado do
      {:ok, mensaje} ->
        Util.mostrar_mensaje(mensaje)

      {:error, mensaje} ->
        Util.mostrar_error(mensaje)
    end

    resultado
  end


  defp validar_longitud(errores, u) do
    if String.length(u) < 5 or String.length(u) > 12 do
      errores ++ ["Debe tener entre 5 y 12 caracteres"]
    else
      errores
    end
  end

  defp validar_minusculas(errores, u) do
    if u != String.downcase(u) do
      errores ++ ["Debe estar completamente en minúscula"]
    else
      errores
    end
  end

  defp validar_espacios(errores, u) do
    if String.contains?(u, " ") do
      errores ++ ["No debe contener espacios"]
    else
      errores
    end
  end

  defp validar_especiales(errores, u) do
    limpio =
      u
      |> String.replace("@", "")
      |> String.replace("#", "")
      |> String.replace("$", "")
      |> String.replace("%", "")

    if limpio != u do
      errores ++ ["No debe contener caracteres especiales (@, #, $, %)"]
    else
      errores
    end
  end

  defp validar_tiene_letra(errores, u) do
    if not String.match?(u, ~r/[a-z]/) do
      errores ++ ["Debe contener al menos una letra"]
    else
      errores
    end
  end

  defp construir_resultado([]), do: {:ok, "Usuario válido"}
  defp construir_resultado(errores), do: {:error, Enum.join(errores, "\n")}
end

ValidadorUsuario.validar()
