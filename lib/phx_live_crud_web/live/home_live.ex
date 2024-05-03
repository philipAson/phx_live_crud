defmodule PhxLiveCrudWeb.HomeLive do
  use PhxLiveCrudWeb, :live_view

  alias PhxLiveCrud.User

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        users: User.get_filtered_users(%{limit: 20}),
        filter_params: %{
          age_from: nil,
          age_to: nil,
          limit: 100,
          sorter: nil
        }
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="home-container">
      <div class="users-container">
        <h1>users</h1>
        <ul class="list_container">
          <li :for={user <- @users} class="list_item">
            <%= user.name %> - age: <%= user.age %>. active: <%= user.is_active %>
          </li>
        </ul>
      </div>
      <div class="filter-container">
        <form class="filter_users" phx-submit="filter">
          <input type="number" placeholder="limit" value={6} name="limit" />
          <select name="sorter">
            <%= Phoenix.HTML.Form.options_for_select(
              sorting_options(),
              @filter_params.sorter
            ) %>
          </select>
          <button type="submit">
            Apply filters
          </button>
        </form>
      </div>
    </div>
    """
  end

  def handle_event("filter", %{"sorter" => sorter, "limit" => limit}, socket) do
    IO.inspect(sorter)
    filter = %{sorter: sorter, limit: limit}
    users = User.get_filtered_users(filter)
    {:noreply, assign(socket, users: users)}
  end

  defp sorting_options do
    [
      {"None", ""},
      {"Age", "age"},
      {"Name", "name"},
      {"Join Date", "join_date"}
    ]
  end
end
