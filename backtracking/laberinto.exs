defmodule Laberinto do

  def resolver(laberinto) do
    visitar(laberinto, 1, 1, [], MapSet.new())
  end

  defp visitar(laberinto, x, y, camino, visitados) do
    cond do
      Enum.at(Enum.at(laberinto, x), y) == 1 ->
        :fail

      MapSet.member?(visitados, {x, y}) ->
        :fail

      x == 4 and y == 4 ->
        {:ok, Enum.reverse([{x, y} | camino])}

      true ->
        camino = [{x, y} | camino]
        visitados = MapSet.put(visitados, {x, y})

        visitar(laberinto, x + 1, y, camino, visitados) ||
        visitar(laberinto, x, y + 1, camino, visitados) ||
        visitar(laberinto, x - 1, y, camino, visitados) ||
        visitar(laberinto, x, y - 1, camino, visitados)
    end
  end

end

laberinto = [
  [1,1,1,1,1,1],
  [1,0,0,1,0,1],
  [1,1,0,1,0,1],
  [1,0,0,0,0,1],
  [1,0,1,1,0,1],
  [1,1,1,1,1,1]
]

resultado = Laberinto.resolver(laberinto)

IO.inspect(resultado)
