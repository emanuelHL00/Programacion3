defmodule Lista do
  def imprimir ([]) do
    :ok
  end

  def imprimir([cabeza | cola])do
    IO.puts(cabeza)
    imprimir(cola)
  end
end

Lista.imprimir([1,2,3,4])
