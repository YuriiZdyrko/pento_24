defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    n = :rand.uniform(3)
    {:ok, assign(socket, time: time(), score: 0, message: "Make a guess:", random_number: n)}
  end

  def render(assigns) do
    ~H"""
    <h2>
      <%= @message %> It's <%= @time %>
    </h2>
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <br />
    <i><%= @random_number %> </i>
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-blue-700
          text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}
        >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    message = if guess == "#{socket.assigns.random_number}" do
      "congrats!!"
    else
      "Your guess: #{guess}. Wrong. Guess again. "
    end
    score = socket.assigns.score - 1
    time = time()

    {:noreply,
     assign(
       socket,
       message: message,
       score: score,
       time: time
     )}
  end
end
