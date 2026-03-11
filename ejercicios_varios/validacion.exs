defmodule Validacion do

  def main do
    usuario = Util.ingresar("Ingrese el nombre de usuario: ", :texto)

    case validar(usuario) do
      {:ok, mensaje} ->
        Util.mostrar_mensaje(mensaje)

      {:error, mensaje} ->
        Util.mostrar_mensaje(mensaje)
    end
  end


  def validar(usuario) do
    usuario
    |> verificar_longitud([])
    |> verificar_espacios(usuario)
    |> verificar_inicio(usuario)
    |> verificar_caracteres(usuario)
    |> verificar_admin(usuario)
    |> resultado()
  end


  # 1️⃣ Longitud entre 6 y 15
  defp verificar_longitud(usuario, errores) do
    if String.length(usuario) < 6 or String.length(usuario) > 15 do
      ["Debe tener entre 6 y 15 caracteres" | errores]
    else
      errores
    end
  end


  # 2️⃣ No espacios
  defp verificar_espacios(errores, usuario) do
    if String.contains?(usuario, " ") do
      ["No puede contener espacios" | errores]
    else
      errores
    end
  end


  # 3️⃣ Debe comenzar con letra
  defp verificar_inicio(errores, usuario) do
    if not Regex.match?(~r/^[a-zA-Z]/, usuario) do
      ["Debe comenzar con una letra" | errores]
    else
      errores
    end
  end


  # 4️⃣ Solo letras y números
  defp verificar_caracteres(errores, usuario) do
    if not Regex.match?(~r/^[a-zA-Z0-9]+$/, usuario) do
      ["Solo puede contener letras y números" | errores]
    else
      errores
    end
  end


  # 5️⃣ No contener "admin"
  defp verificar_admin(errores, usuario) do
    if String.contains?(String.downcase(usuario), "admin") do
      ["No puede contener la palabra admin" | errores]
    else
      errores
    end
  end


  defp resultado([]) do
    {:ok, "Usuario válido"}
  end

  defp resultado(errores) do
    mensaje =
      errores
      |> Enum.reverse()
      |> Enum.join(" y ")

    {:error, mensaje}
  end

end

Validacion.main()
