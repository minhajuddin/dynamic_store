defmodule DB do
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_state) do
    :ets.new(:db, [:named_table, :public, {:write_concurrency, true}, {:read_concurrency, true}])
    {:ok, :nostate}
  end

  def get(key) do
    case :ets.lookup(:db, key) do
      [{_, val}] -> {:ok, val}
      _ -> :not_found
    end
  end

  def put(key, val) do
    :ets.insert(:db, {key, val})
  end

end
