defmodule KvPlug do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200,
              """
              GET /:key
              POST /:key with body
              """
    )
  end

  get "/:key" do
    case conn |> key |> DB.get do
      {:ok, val} -> send_resp(conn, 200, val)
      :not_found -> send_resp(conn, 404, "404, Not Found")
    end
  end

  post "/:key" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    conn |> key |> DB.put(body)

    send_resp(conn, 200, "OK")
  end

  def key(%Plug.Conn{} = conn) do
    conn.params["key"]
  end
end
