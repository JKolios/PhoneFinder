defmodule PhoneFinderWeb.PageController do
  use PhoneFinderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
