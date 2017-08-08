defmodule DB do
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    {:ok, init_state(state)}
  end

  # initializes the mnesia database
  defp init_state(state) do
    nodes = [node()]
    :mnesia.create_schema(nodes) |> IO.inspect(label: "SCHEMA")
    :rpc.multicall(nodes, :mnesia, :start, []) |> IO.inspect(label: "START")
    create_tables(nodes)
    :nostate
  end

  # call this after doing init
  def create_tables(nodes) do
    :mnesia.create_table(Search, [
      attributes: [:id, :data],
      disc_copies:  nodes,
      type: :set, # :ordered_set, :bag
    ]) |> IO.inspect(label: "TABLE")
  end

  def put(search_id, data) do
    :mnesia.transaction(fn ->
      :mnesia.write({Search, search_id, data})
    end)
  end

  def get(search_id) do
    :mnesia.transaction(fn ->
      :mnesia.read(Search, search_id)
    end) |> inspect
  end

end
