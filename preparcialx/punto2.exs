defmodule Punto2 do
  def main do
    IO.puts("Numero par si o no")
    numero = Util.ingresar("Ingrese el numero ", :entero)

    if par?(numero) do
      IO.puts("es par")
    else
      IO.puts("no es par")
    end


    IO.puts("\n")
    IO.puts("Segunda funcion clasificacion de su edad")
    edad = Util.ingresar("Igrese su edad: ", :entero)

    IO.puts("Su edad se clasifica en #{clasificacion_edad(edad)}")


  end

  def par?(n) do
    rem(n, 2) == 0
  end

  def clasificacion_edad(e) do
    cond do
      e < 12 -> "niño"
      e < 18 -> "joven"
      true -> "adulto"
    end
  end



end

Punto2.main()
