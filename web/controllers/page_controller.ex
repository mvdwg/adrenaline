defmodule Adrenaline.PageController do
  use Adrenaline.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def host(conn, _params) do
    render conn, "host.html"
  end
end
