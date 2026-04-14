defmodule Matrushka do
  def main do
    numero = Util.ingresar("Ingrese el numero de matrushkas que desea abrir", :entero)
    imprimir_matrushka(numero)
  end

  def imprimir_matrushka(1) do
    IO.puts("abriendo matrushka numero 1")
    IO.puts("cerrando matrushka numero 1")
  end

  def imprimir_matrushka(numero) when numero > 1 do
    IO.puts("abriendo matrushka numero #{numero}")
    imprimir_matrushka(numero-1)
    IO.puts("Cerrando matrushka numero #{numero}")

  end

end

Matrushka.main()
