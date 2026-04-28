defmodule Proceso do
    @cantidad_procesos_internos 5

    def main do
        Benchmark.determinar_tiempo_ejecucion({Proceso, :simulacion, [@cantidad_procesos_internos]})
        |>generar_mensaje()
        |>Util.mostrar_mensaje()
    end

    def simulacion(cantidad_procesos_internos) do
        datos_prueba = [{"A", 2500}, {"\tB", 1500}, {"\t\tC", 500}, {"\t\t\tD", 3500}]

        Enum.each()

    end
end
