defmodule Tienda do

  def main do
    producto = Util.ingresar("Ingrese el producto que desee: ", :texto)
    garantia = Util.ingresar("Ingrese si desea una garantia (si/no): ", :boolean)
    envio = Util.ingresar("Ingrese que tipo de envio desea: ", :texto)
    seguro = Util.ingresar("Ingrese si desea tener un seguro (si/no): ", :boolean)

    producto =
      producto
      |> String.trim()
      |> String.downcase()
      |> String.to_atom()

    case precio_base(producto) do
      {:ok, tarifa_base} ->

        {_, valor_envio, valor_garantia, valor_seguro, precio_final} =
          calcular_precio(producto, garantia, envio, seguro)

        Util.mostrar_mensaje("Base: #{tarifa_base}")
        Util.mostrar_mensaje("Envio: #{valor_envio}")
        Util.mostrar_mensaje("Garantia: #{valor_garantia}")
        Util.mostrar_mensaje("Seguro: #{valor_seguro}")
        Util.mostrar_mensaje("Total: #{precio_final}")

      {:error, mensaje} ->
        IO.puts("Error: #{mensaje}")
    end

  end


  def precio_base(:laptop), do: {:ok, 2500}
  def precio_base(:tablet), do: {:ok, 1200}
  def precio_base(:celular), do: {:ok, 1800}
  def precio_base(:accesorio), do: {:ok, 150}
  def precio_base(_), do: {:error, "Producto no válido"}



  def precio_envio(producto, _envio) when producto == :laptop, do: 15

  def precio_envio(_producto, envio) do
    envio = envio |> String.trim() |> String.downcase()

    cond do
      envio == "estandar" -> 15
      envio == "express" -> 35
      true -> 0
    end
  end



  def porcentaje_garantia(garantia) do
    cond do
      garantia -> 0.08
      true -> 0
    end
  end



  def porcentaje_seguro(seguro) do
    cond do
      seguro -> 0.05
      true -> 0
    end
  end



  def calcular_precio(producto, garantia, envio, seguro) do
    {:ok, tarifa_base} = precio_base(producto)

    valor_envio = precio_envio(producto, envio)

    valor_garantia = tarifa_base * porcentaje_garantia(garantia)
    valor_seguro = tarifa_base * porcentaje_seguro(seguro)

    precio_final = tarifa_base + valor_envio + valor_garantia + valor_seguro

    {tarifa_base, valor_envio, valor_garantia, valor_seguro, precio_final}
  end

end


Tienda.main()
