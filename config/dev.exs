use Mix.Config

config :mnesia,
  dir: (Path.expand("../db", __DIR__) |> to_charlist)
