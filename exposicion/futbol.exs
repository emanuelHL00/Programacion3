defmodule FutbolDB do
  def main do
    db = datos_iniciales()
    menu(db)
  end


  def datos_iniciales do
    %{
      "La Liga" => [
        equipo("Real Madrid", ["bellingham","vinicius"], [{"Champions",15},{"Liga",36}]),
        equipo("Barcelona", ["lewandowski","pedri"], [{"Champions",5},{"Liga",27}]),
        equipo("Atletico Madrid", ["griezmann"], [{"Liga",11}]),
        equipo("Sevilla", ["alexis"], [{"Europa League",7}]),
        equipo("Valencia", ["gaya"], [{"Liga",6}])
      ],

      "Premier League" => [
        equipo("Manchester City", ["haaland"], [{"Premier",9}]),
        equipo("Manchester United", ["sesko"], [{"Premier",20}]),
        equipo("Liverpool", ["salah"], [{"Champions",6}]),
        equipo("Chelsea", ["enzo"], [{"Champions",2}]),
        equipo("Arsenal", ["saka"], [{"Premier",13}])
      ],

      "Bundesliga" => [
        equipo("Bayern Munich", ["kane"], [{"Bundesliga",32}]),
        equipo("Borussia Dortmund", ["sancho"], [{"Bundesliga",8}]),
        equipo("Leipzig", ["olmo"], []),
        equipo("Leverkusen", ["schick"], []),
        equipo("Schalke", ["terodde"], [{"Bundesliga",7}])
      ],

      "Serie A" => [
        equipo("Juventus", ["mckennie"], [{"Serie A",36}]),
        equipo("Inter", ["lautaro"], [{"Serie A",19}]),
        equipo("Milan", ["leao"], [{"Champions",7}]),
        equipo("Roma", ["dybala"], []),
        equipo("Napoli", ["mctomminay"], [{"Serie A",3}])
      ],

      "Ligue 1" => [
        equipo("PSG", ["doue"], [{"Ligue 1",11}]),
        equipo("Lyon", ["endrick"], [{"Ligue 1",7}]),
        equipo("Marseille", ["grenwood"], [{"Champions",1}]),
        equipo("Monaco", ["mika bereth"], [{"Ligue 1",8}]),
        equipo("Lille", ["yilmaz"], [{"Ligue 1",4}])
      ]
    }
  end

  def equipo(nombre, jugadores, palmares) do
    %{
      nombre: nombre,
      jugadores: jugadores,
      palmares: palmares
    }
  end



  def menu(db) do
    Util.mostrar_mensaje("\n BASE DE DATOS DE FUTBOL")

    Util.mostrar_mensaje("1 Ver ligas")
    Util.mostrar_mensaje("2 Ver equipos")
    Util.mostrar_mensaje("3 Agregar equipo")
    Util.mostrar_mensaje("4 Eliminar equipo")
    Util.mostrar_mensaje("5 Modificar equipo")
    Util.mostrar_mensaje("6 Agregar jugador")
    Util.mostrar_mensaje("7 Ver palmares")
    Util.mostrar_mensaje("8 Buscar jugador")
    Util.mostrar_mensaje("9 simula partido")
    Util.mostrar_mensaje("10 Salir")

    opcion = Util.ingresar("Seleccione: ", :entero)

    case opcion do
      1 -> ver_ligas(db)
      2 -> ver_equipos(db)
      3 -> agregar_equipo(db)
      4 -> eliminar_equipo(db)
      5 -> modificar_equipo(db)
      6 -> agregar_jugador(db)
      7 -> ver_palmares(db)
      8 -> buscar_jugador(db)
      9 -> simular_partido(db)
      10 -> Util.mostrar_mensaje("Adios")
      _ -> menu(db)
    end
  end



  def seleccionar_liga(db) do
    ligas = Map.keys(db)

    Util.mostrar_mensaje("\nSeleccione una liga:")

    ligas
    |> Enum.with_index(1)
    |> Enum.each(fn {liga,i} ->
      Util.mostrar_mensaje("#{i}. #{liga}")
    end)

    opcion = Util.ingresar("Numero: ", :entero)

    Enum.at(ligas, opcion-1)
  end



  def seleccionar_equipo(equipos) do

    equipos
    |> Enum.with_index(1)
    |> Enum.each(fn {equipo,i} ->
      Util.mostrar_mensaje("#{i}. #{equipo.nombre}")
    end)

    opcion = Util.ingresar("Numero: ", :entero)

    Enum.at(equipos, opcion-1)
  end



  def ver_ligas(db) do

    Map.keys(db)
    |> Enum.each(fn liga ->
      Util.mostrar_mensaje(liga)
    end)

    menu(db)
  end


  def ver_equipos(db) do

    liga = seleccionar_liga(db)

    equipos = Map.get(db, liga)

    Enum.each(equipos, fn e ->
      Util.mostrar_mensaje(e.nombre)
    end)

    menu(db)
  end


  def ver_palmares(db) do

    liga = seleccionar_liga(db)

    equipos = Map.get(db, liga)

    equipo = seleccionar_equipo(equipos)

    Enum.each(equipo.palmares, fn {titulo,cantidad} ->
      Util.mostrar_mensaje("#{titulo}: #{cantidad}")
    end)

    menu(db)
  end

  def ingresar_jugadores(lista \\ []) do
  jugador = Util.ingresar("Nombre del jugador (fin para terminar): ", :texto)

  if String.downcase(jugador) == "fin" do
    lista
  else
    ingresar_jugadores(lista ++ [jugador])
  end
end

def ingresar_palmares(lista \\ []) do
  titulo = Util.ingresar("Titulo (fin para terminar): ", :texto)

  if String.downcase(titulo) == "fin" do
    lista
  else
    cantidad = Util.ingresar("Cantidad: ", :entero)
    ingresar_palmares(lista ++ [{titulo, cantidad}])
  end
end



  def agregar_equipo(db) do

  liga = seleccionar_liga(db)

  nombre = Util.ingresar("Nombre del equipo: ", :texto)

  Util.mostrar_mensaje("Ingrese jugadores del equipo")
  jugadores = ingresar_jugadores()

  Util.mostrar_mensaje("Ingrese palmares del equipo")
  palmares = ingresar_palmares()

  nuevo = equipo(nombre, jugadores, palmares)

  equipos = Map.get(db, liga)

  nuevos = [nuevo | equipos]

  db = Map.put(db, liga, nuevos)

  Util.mostrar_mensaje("Equipo agregado")

  menu(db)
end


  def agregar_jugador(db) do

    liga = seleccionar_liga(db)

    equipos = Map.get(db, liga)

    equipo = seleccionar_equipo(equipos)

    jugador = Util.ingresar("Jugador nuevo: ", :texto)

    nuevos =
      Enum.map(equipos, fn e ->
        if e.nombre == equipo.nombre do
          %{e | jugadores: e.jugadores ++ [jugador]}
        else
          e
        end
      end)

    db = Map.put(db, liga, nuevos)

    Util.mostrar_mensaje("Jugador agregado")

    menu(db)
  end



  def modificar_equipo(db) do

  liga = seleccionar_liga(db)

  equipos = Map.get(db, liga)

  equipo = seleccionar_equipo(equipos)

  nuevo_nombre = Util.ingresar("Nuevo nombre del equipo: ", :texto)

  Util.mostrar_mensaje("Ingrese los nuevos jugadores")
  jugadores = ingresar_jugadores()

  Util.mostrar_mensaje("Ingrese el nuevo palmares")
  palmares = ingresar_palmares()

  nuevos =
    Enum.map(equipos, fn e ->
      if e.nombre == equipo.nombre do
        equipo(nuevo_nombre, jugadores, palmares)
      else
        e
      end
    end)

  db = Map.put(db, liga, nuevos)

  Util.mostrar_mensaje("Equipo modificado")

  menu(db)
end



  def eliminar_equipo(db) do

    liga = seleccionar_liga(db)

    equipos = Map.get(db, liga)

    equipo = seleccionar_equipo(equipos)

    nuevos =
      Enum.reject(equipos, fn e ->
        e.nombre == equipo.nombre
      end)

    db = Map.put(db, liga, nuevos)

    Util.mostrar_mensaje("Equipo eliminado")

    menu(db)
  end



  def buscar_jugador(db) do

    jugador = Util.ingresar("Jugador: ", :texto)

    db
    |> Enum.each(fn {liga,equipos} ->

      Enum.each(equipos, fn equipo ->

        if String.downcase(jugador) in equipo.jugadores do
          Util.mostrar_mensaje("#{jugador} juega en #{equipo.nombre} (#{liga})")
        end

      end)

    end)

    menu(db)
  end

  def simular_partido(db) do

  liga = seleccionar_liga(db)

  equipos = Map.get(db, liga)

  Util.mostrar_mensaje("Seleccione el primer equipo")
  equipo1 = seleccionar_equipo(equipos)

  Util.mostrar_mensaje("Seleccione el segundo equipo")
  equipo2 = seleccionar_equipo(equipos)

  goles1 = Util.ingresar("Goles de #{equipo1.nombre}: ", :entero)
  goles2 = Util.ingresar("Goles de #{equipo2.nombre}: ", :entero)

  Util.mostrar_mensaje("#{equipo1.nombre} #{goles1} - #{goles2} #{equipo2.nombre}")

  if goles1 > goles2 do
    Util.mostrar_mensaje("Ganador: #{equipo1.nombre}")
  else
    if goles2 > goles1 do
      Util.mostrar_mensaje("Ganador: #{equipo2.nombre}")
    else
      Util.mostrar_mensaje("Empate")
    end
  end

  menu(db)
end

end

FutbolDB.main()
