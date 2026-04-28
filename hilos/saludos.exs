defmodule Saludos do
  def main do
    IO.puts("Lanzando saludos en paralelo...\n")

    nombres = ["Ana", "Luis", "María", "Carlos", "Sofía"]

    tareas = Enum.map(nombres, fn nombre ->
      Task.async(fn -> saludar(nombre) end)
    end)

    Task.await_many(tareas)

    IO.puts("\nTodos saludaron!")
  end

  def saludar(nombre) do
    Process.sleep(:rand.uniform(2000))
    IO.puts("Hola, #{nombre}! )")
  end

end

Saludos.main()
