defmodule PhoneFinderWeb.PhoneRecordSearchLive do
  use PhoneFinderWeb, :live_view

  def mount(_params, %{}, socket) do
    socket =
      socket
      |> assign(:search_term, "")
      |> assign(:search_results, %{})
    {:ok, socket}
  end

  def handle_event("search_term_change", value, socket) do
    search_results = if String.length(value["search_term"]["term"]) > 2 do
      PhoneFinder.Phones.search_phone_records(value["search_term"]["term"])
    else
      []
    end
    socket = socket
      |> assign(:search_results, search_results)
      |> assign(:search_term, value["search_term"]["term"])
    {:noreply, socket}
  end
end
