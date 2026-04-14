defmodule Lista do
  def main do
    lista = [1,2,3,4,5]
    imprimir_lista(lista)
  end

  def imprimir_lista([]) do
    :ok
  end

  def imprimir_lista([x | lista])do
    IO.puts(x)
    imprimir_lista(lista)
    IO.puts(x)
  end

end

Lista.main()
