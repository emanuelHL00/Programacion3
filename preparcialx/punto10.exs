defmodule Punto10 do
  def main do

    lista = [2,2,2,2,2,2,2,1,1,1,1,1]
    IO.puts(contar_pares(lista))

    numero = 123
    IO.puts(sumar_digitos(numero))

    lista2 = [-1,-5,2,5,3,-4]
    IO.inspect(eliminar_negativos(lista2))

    lista3 = [1,6,3,4]
    IO.puts(lista_menor_mayor(lista3))

  end

  def contar_pares([]), do: 0
  def contar_pares([h|t]) do
    if rem(h,2) == 0 do
      1 + contar_pares(t)
    else
      contar_pares(t)
    end
  end

  def sumar_digitos(n), do: sumar_digitos(n, 0)
  def sumar_digitos(0,acc), do: acc

  def sumar_digitos(n, acc) do
    digito = rem(n,10)
    sumar_digitos(div(n,10), acc + digito)
  end

  def eliminar_negativos([]), do: []
  def eliminar_negativos([h | t]) do
    if h >= 0 do
      [h| eliminar_negativos(t)]
    else
      eliminar_negativos(t)
    end
  end

  def lista_menor_mayor([]), do: true
  def lista_menor_mayor([_]), do: true
  def lista_menor_mayor([h, t | c]) do
    if h <= t do
      lista_menor_mayor([t | c])
    else
      false
    end

  end

end

Punto10.main()
