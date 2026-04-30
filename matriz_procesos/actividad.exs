defmodule Matriz_Procesos do

  def main do
    m = [
      [60, 22, 41, 5],
      [13, 33, 44, 5],
      [89, 10, 100, 94],
      [5, 101, 6, 34]
    ]

    IO.puts("iniciando procesos...\n")

    t1 = Task.async(fn -> proceso_t1(m) end)
    t2 = Task.async(fn -> proceso_t2(m) end)

    a = Task.await(t1)
    b = Task.await(t2)

    IO.puts("\nAmbos procesos terminaron")

    c = s3(a, b)

    s4(c)
  end

  def proceso_t1(matriz) do
    IO.puts("Proceso t1: calculando s1...")
    resultado = s1(matriz)
    IO.puts("Proceso t1: resultado = #{resultado}")
    resultado
  end

  def proceso_t2(matriz) do
    IO.puts("Proceso t2: calculando s2...")
    resultado = s2(matriz)
    IO.puts("Proceso t2: resultado = #{resultado}")
    resultado
  end

  def s1(matriz) do
    Enum.with_index(matriz)
    |> Enum.reduce(0, fn {fila, i}, acc ->
      suma_fila =
        Enum.with_index(fila)
        |> Enum.reduce(0, fn {val, j}, acc2 ->
          if i > j do
            acc2 + val
          else
            acc2
          end
        end)

      acc + suma_fila
    end)
  end

  def s2(matriz) do
    lista = List.flatten(matriz)
    Enum.sum(lista) / length(lista)
  end

  def s3(a, b) do
    IO.puts("\nejecutando s3")
    a * b
  end

  def s4(c) do
    IO.puts("resultado final = #{c}")
  end

end

Matriz_Procesos.main()
