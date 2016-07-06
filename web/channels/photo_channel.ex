defmodule PhotoFeedApi.PhotoChannel do
  use PhotoFeedApi.Web, :channel

  def join("photo", payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    response =
      PhotoFeedApi.Photo.get_data()
      |> Poison.encode!()

    push socket, "feed", %{body: response}
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("msg", payload, socket) do
    broadcast socket, "msg", payload
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("new-photo", payload, socket) do
    photo_data =
      PhotoFeedApi.Photo.upload(payload)
      |> Poison.encode!()
    broadcast socket, "new-photo", %{body: photo_data}
    {:reply, {:ok, payload}, socket}
  end

  def handle_out("new-photo", payload, socket) do
    push socket, "new-photo", payload
    {:noreply, socket}
  end

  def handle_out("msg", payload, socket) do
    push socket, "msg", payload
    {:noreply, socket}
  end
end
