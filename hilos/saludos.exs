defmodule Saludos do
  def main do
    IO.puts("Lanzando saludos en paralelo...\n")

    nombres = ["Ana", "Luis", "María", "Carlos", "Sofía"]

    tareas =
      Enum.map(nombres, fn nombre ->
        Task.async(fn -> saludar(nombre) end)
      end)

    resultados = esperar_tareas(tareas)

    IO.puts("\nResultados finales:")
    IO.inspect(resultados)
  end

  def saludar(nombre) do
    tiempo = :rand.uniform(2000)
    Process.sleep(tiempo)
    "Hola, #{nombre} (tardó #{tiempo} ms)"
  end

  def esperar_tareas(tareas) do
    Enum.map(tareas, fn tarea ->
      try do
        Task.await(tarea, 1500)  
      catch
        :exit, _ -> "Una tarea falló o tardó demasiado"
      end
    end)
  end
end

Saludos.main()
