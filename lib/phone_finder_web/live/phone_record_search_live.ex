defmodule PhoneFinderWeb.PhoneRecordSearchLive do
  use PhoneFinderWeb, :live_view

  def mount(_params, %{}, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 3000)
    socket =
      socket
      |> assign(:search_term, "")
      |> assign(:time, DateTime.utc_now)
      |> assign(:search_results, %{})
    {:ok, socket}
  end

  def handle_event("search_term_change", value, socket) do
    socket =
      socket
      |> assign(:search_term, value["search_term"]["term"])
      |> assign(:time, DateTime.utc_now)
      |> assign(:search_results, PhoneFinder.Phones.search_phone_records(value["search_term"]["term"]))
    {:noreply, socket}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 3000)
    socket = socket
    |> assign(:time, DateTime.utc_now)
    {:noreply, socket}
  end
end
