defmodule PhxLiveCrudWeb.HomeLive do
  use PhxLiveCrudWeb, :live_view

  alias PhxLiveCrud.User

  def mount(_params, _session, socket) do
    users = User.get_all_users()

    socket =
      assign(socket,
        users: users,
        age: nil,
        status: nil,
        email: nil,
        name: nil,
        sorter: nil,
        limit: nil
      )

    # Let's assume a fixed temperature for now
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="home-container">
      <div class="users-container">
        <h1>users</h1>
        <ul class="list_container">
          <%= for user <- @users do %>
            <li class="list_item">
              <%= user.name %> - age: <%= user.age %>. active: <%= user.is_active %>
            </li>
          <% end %>
        </ul>
      </div>
      <div class="filter-container">
        <%!-- filter options here --%>
        <%!-- <label>Age:</label>
        <input type="range" min="0" max="500" value={@age || 0} phx-change="filter_age">
        <label>Status:</label>
        <input type="checkbox" <%= if @status, do: "checked" %> phx-change="toggle_status">
        <label>Limit:</label>
        <input type="number" value="<%= @limit || 10 %>" phx-change="change_limit">
        <div>
          <label><input type="radio" name="sorter" value="age" <%= if @sorter == "age", do: "checked" %> phx-change="change_sort"> Age</label>
          <label><input type="radio" name="sorter" value="name" <%= if @sorter == "name", do: "checked" %> phx-change="change_sort"> Name</label>
          <label><input type="radio" name="sorter" value="join_date" <%= if @sorter == "join_date", do: "checked" %> phx-change="change_sort"> Join Date</label>
        </div> --%>
      </div>
    </div>
    """
  end
end
