defmodule Util do
  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

  def mostrar_mensaje_java(mensaje) do
    System.cmd("java",["-cp", ".", "Mensaje", mensaje])
  end


  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero) do
    try do
      mensaje
    |> Util.ingresar(:texto)
    |> String.to_integer()
    rescue
      ArgumentError ->
        "Error se espera un entero"
        |> mostrar_error()

        mensaje
        |> ingresar(:entero)
    end
  end

  def ingresar(mensaje, :real) do
    try do
      mensaje
    |> Util.ingresar(:texto)
    |> String.to_float()
    rescue
      ArgumentError ->
        "Error se espera un real"
        |> mostrar_error()

        mensaje
        |> ingresar(:real)
    end
  end


  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

  def ingresar(mensaje, pasrser, tipo_dato) do
    try do
      mensaje
      |>ingresar(:texto)
      |>pasrser.()
    rescue
      ArgumentError ->
        "Error, se espera un numero #{tipo_dato}\n"
        |> mostrar_error()

        mensaje
        |> ingresar(parser, tipo_dato)
    end
  end

end
