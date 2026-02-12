defmodule CrudNumeros do

  def crear(lista, numero) do
    lista ++ [numero]
  end

  def leer(lista) do
    IO.puts("Lista actual:")
    IO.inspect(lista)
    lista
  end

  def actualizar(lista, viejo, nuevo) do
    Enum.map(lista, fn x ->
      if x == viejo do
        nuevo
      else
        x
      end
    end)
  end

  def eliminar(lista, numero) do
    Enum.filter(lista, fn x -> x != numero end)
  end

end


lista = [1, 2, 3]

lista = CrudNumeros.crear(lista, 100)
lista = CrudNumeros.crear(lista, 4)
lista = CrudNumeros.leer(lista)
lista = CrudNumeros.actualizar(lista, 2, 99)
lista = CrudNumeros.eliminar(lista, 3)
lista = CrudNumeros.eliminar(lista, 99)


IO.inspect(lista)
