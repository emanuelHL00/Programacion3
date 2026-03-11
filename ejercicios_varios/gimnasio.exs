defmodule Gimnasio do
  def main do
    tipo_plan = Util.ingresar("Ingresa el tipo de plan que deseas (basico , estandar o premium): ", :texto)
    permanencia = Util.ingresar("Ingresa los meses de permanencia que deseas: ", :entero)
    piscina = Util.ingresar("Deseas piscina (si/no): ", :boolean)
    entrenador = Util.ingresar("Deseas entrenador (si/no): ", :boolean)

    tipo_plan = tipo_plan |> String.to_atom()

    {base, descuento, recargos, total} =
      calcular_precio(tipo_plan, permanencia, piscina, entrenador)

    Util.mostrar_mensaje("Base: #{base}")
    Util.mostrar_mensaje("Descuento: #{descuento}")
    Util.mostrar_mensaje("Recargos: #{recargos}")
    Util.mostrar_mensaje("Total: #{total}")


  end

  def tarifa_base(:basico), do: 80000
  def tarifa_base(:estandar), do: 120000
  def tarifa_base(:premium), do: 160000


  def descuento_permanencia(permanencia) when permanencia <3, do: 0.0
  def descuento_permanencia(permanencia) when permanencia >=3 and permanencia <=6, do: 0.10
  def desceutno_permanencia(permanencia) when permanencia >6, do: 0.18


  def recargos(piscina, entrenador) do
    cond do
      piscina and entrenador -> 0.40
      entrenador -> 0.25
      piscina -> 0.15
      true -> 0
    end
  end

  def calcular_precio(tipo_plan, permanencia, piscina, entrenador) do
    base = tarifa_base(tipo_plan)

    valor_descuento = base * descuento_permanencia(permanencia)
    valor_recargos = (base - valor_descuento) * recargos(piscina, entrenador)
    valor_total = base - valor_descuento + valor_recargos

    {base, valor_descuento, valor_recargos, valor_total}

  end

end

Gimnasio.main()
