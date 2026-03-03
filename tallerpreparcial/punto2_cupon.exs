defmodule Cupon do
  def validar(codigo) do
    codigo
    |> verificar_longitud([])
    |> verificar_mayuscula(codigo)
    |> verificar_numero(codigo)
    |> verificar_espacios(codigo)
    |> resultado()
  end

  defp verificar_longitud(codigo, errores) do
    if String.length(codigo) < 10 do
      errores ++ ["debe tener al menos 10 caracteres"]
    else
      errores
    end
  end


  defp verificar_mayuscula(errores, codigo) do
    if String.downcase(codigo) == codigo do
      errores ++ ["debe contener al menos una letra mayúscula"]
    else
      errores
    end
  end


  defp verificar_numero(errores, codigo) do
    tiene_numero = String.contains?(codigo, ["0","1","2","3","4","5","6","7","8","9"])
    if not tiene_numero do
      errores ++ ["debe contener al menos un número"]
    else
      errores
    end
  end


  defp verificar_espacios(errores, codigo) do
    sin_espacios = String.replace(codigo, " ", "")
    if sin_espacios != codigo do
      errores ++ ["no debe contener espacios"]
    else
      errores
    end
  end


  defp resultado([]) do
    {:ok, "Cupón válido"}
  end

  defp resultado(errores) do
    mensaje = "El cupón " <> Enum.join(errores, " y ")
    {:error, mensaje}
  end

end

IO.puts("\n=== VALIDADOR DE CUPÓN PROMOCIONAL ===\n")

codigo = Util.ingresar("Ingrese el código del cupón: ", :texto)

IO.puts("")
case Cupon.validar(codigo) do
  {:ok, mensaje} ->
    IO.puts("#{mensaje}")

  {:error, mensaje} ->
    IO.puts("Error: #{mensaje}.")
end
