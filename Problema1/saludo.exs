defmodule Saludo do
    def main do
        "Bienvenidos a la empresa Once Ltda"
        |> Util.mostrar_mensaje()
    end
end

Saludo.main()
