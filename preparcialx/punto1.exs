defmodule Punto1 do
  def main do
    texto = "hola mundo"
    IO.puts(contar_vocales(texto))

    IO.puts(contar_vocales_sin_grapheme(texto))
  end

  def contar_vocales(cadena) do
    contar(String.graphemes(cadena))
  end

  defp contar([]), do: 0
  defp contar([h | t ]) do
    if h in ["a","e","i","o","u","A","E","I","O","U"] do
      1 + contar(t)
    else
      contar(t)
    end
  end

  def contar_vocales_sin_grapheme(cadena) do
    if cadena == "" do
      0
    else
      letra = String.at(cadena, 0)
      resto = String.slice(cadena, 1, String.length(cadena) - 1)

      if letra in ["a","e","i","o","u","A","E","I","O","U"] do
        1 + contar_vocales_sin_grapheme(resto)
      else
        contar_vocales_sin_grapheme(resto)
      end
    end
  end


end

Punto1.main()
