defmodule Util do
  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

  def mostrar_mensaje_java(mensaje) do
    System.cmd("java",["-cp", ".", "Mensaje", mensaje])
  end

end
