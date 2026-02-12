defmodule Saludo do
    def main do
        "Bienvenidos a la empresa Once Ltda"
        |> Util.mostrar_mensaje_java()
    end
end

Saludo.main()
