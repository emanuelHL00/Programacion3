defmodule Punto1 do
  def main do
    texto = "hola mundo"

    IO.puts("Con graphemes:")
    IO.puts(contar_vocales(texto))

    IO.puts("Sin graphemes:")
    IO.puts(contar_vocales_sin_graphemes(texto))
  end

  def contar_vocales(cadena) do
    contar(String.graphemes(cadena))
  end

  defp contar([]), do: 0

  defp contar([cabeza | cola]) do
    if cabeza in ["a","e","i","o","u","A","E","I","O","U"] do
      1 + contar(cola)
    else
      contar(cola)
    end
  end

  def contar_vocales_sin_graphemes(cadena) do
    contar_charlist(String.to_charlist(cadena))
  end

  defp contar_charlist([]), do: 0

  defp contar_charlist([cabeza | cola]) do
    if cabeza in 'aeiouAEIOU' do
      1 + contar_charlist(cola)
    else
      contar_charlist(cola)
    end
  end

end

Punto1.main()
