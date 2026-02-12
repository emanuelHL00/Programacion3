defmodule Util do
  def mostrar_mensaje(mensaje) do
    System.cmd("python3", ["mostrar_dialogo.py", mensaje])
  end
end
