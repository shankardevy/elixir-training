defmodule HelloOtp do
  use GenServer

  def init(ops) do
    {:ok, ops}
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def handle_call({:city, city}, _from, state) do
    case city do
      "Chennai" ->
        {:ok, response} = weather_api()
        reply = response.body
        |> Jason.decode!
        {:reply,  reply, state}
      _ ->
        {:reply, :city_not_found, state}
    end
  end

  defp weather_api() do
    Tesla.get("https://api.openweathermap.org/data/2.5/weather?lat=13.0474878&lon=80.0689268&appid=30d857db5ae1c1e7a2c669ff769deab1")
  end

  # @spec get_weather(atom | pid | {atom, any} | {:via, atom, any}, any) :: any
  def get_weather(city) do
    GenServer.call(__MODULE__, {:city, city})
  end

  def hello do
    :world
  end
end
