defmodule Saludo do
  def saludar do
    {{_anio, _mes, _dia }, {hora, _min, _seg}} = :calendar.local_time()

    nombre = Util.ingresar("Ingresa el nombre de usuario: ", :texto)

    mensaje = cond do
      hora >= 0 and hora <= 11 -> "Buenos dias #{nombre}"
      hora >= 12 and hora <= 17 -> "Buenas tardes #{nombre}"
      hora >= 18 and hora <= 23 -> "Buenas noches #{nombre}"
    end

    Util.mostrar_mensaje(mensaje)

  end
end

Saludo.saludar()
