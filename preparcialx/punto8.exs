defmodule Punto8 do
  def main do
    cadena = "Mbappe es el mejor jugador del mundo"
    IO.puts(contar_vocales(cadena))
    IO.puts(contar_vocales_sin_graphemes(cadena))

  end

  def contar_vocales(cadena) do
    lista = String.graphemes(cadena)
    contar_lista(lista)
  end

  def contar_lista([]), do: 0
  def contar_lista([h|t]) do
    if h in ["a","e","i","o","u","A","E","I","O","U"] do
      1 + contar_lista(t)
    else
      contar_lista(t)
    end
  end

  def contar_vocales_sin_graphemes(cadena) do
    lista = String.split(cadena, "", trim: true)
    contar_lista_sin_graphemes(lista)
  end

  def contar_lista_sin_graphemes([]), do: 0
  def contar_lista_sin_graphemes([h|t]) do
    if h in ["a","e","i","o","u","A","E","I","O","U"] do
      1 + contar_lista(t)
    else
      contar_lista(t)
    end
  end


end

Punto8.main()
