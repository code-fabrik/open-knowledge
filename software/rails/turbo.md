# Turbo

## Turbo Drive

Turbo Drive is mostly what Turbolinks was earlier. Link clicks and form submissions are automatically intercepted, and instead of a full page load, Turbo loads the target using `fetch` and replaces the `<body>` element. This prevents the browser from needing to reparse CSS and JS resources.

To disable Drive for a single element (a link or a form), annotate it with `data-turbo="false"`.

## Turbo Frames

Turbo Frames allows developers to replace only parts of a page when the user clicks a link or submits a form. This can be used to show an inline form in a list of editable items.

To use turbo frames, use the `turbo_frame_tag` helper and pass the ActiveRecord entity to the helper:

`todos/index.html.erb`

```erb
<% @todos.each do |todo| %>
  <%= turbo_frame_tag todo do %>
    <div><%= todo.title %> <%= link_to 'edit', edit_todo_path(todo) %></div>
  <% end %>
<% end %>
```

All navigations that lead to a page containing the same tag will automatically injected into the existing frame.

`todos/edit.html.erb`

```erb
<%= turbo_frame_tag @todo do %>
  <%= simple_form_for @todo do |f| %>
    <%= f.input :title %>
    <%= f.submit %>
  <% end %>
<% end %>
```

Editing an item of the list will inject the form into the list. Saving the form will replace the form with the updated list item.

## Turbo Streams

Streams are used to live update pages over a websocket connection.

To subscribe to a particular stream on the frontend, use the turbo_stream_from tag.

`todos/index.html.erb`

```erb
<%= turbo_stream_from current_user, "todos" %>
```

It is important to scope the stream to the owning entity. Without the `current_user` above, all updates to any of the todos would be sent to all users.

To deliver a live update from the backend, you can choose how the update should be treated on the frontend. You can either append or prepend a new item to a container, you can replace an existing item (losing all event handlers), update the content of an existing item (keeping the handlers), remove an item, or add an item before or after a specific other item.

Delivering updates can either be done as a response to a controller action:

`todos_controller.rb`

```rb
def create
  todo = current_user.todos.create!(params.require(:todo).permit(:text))

  respond_to do |format|
    format.turbo_stream { render turbo_stream: turbo_stream.append(:todos, partial: "todos/todo", locals: { todo: todo }) }
    format.html         { redirect_to todos_url }
  end
end

def destroy
  todo = current_user.todos.find(params[:id])
  todo.destroy

  respond_to do |format|
    format.turbo_stream { render turbo_stream: turbo_stream.remove(todo) }
    format.html         { redirect_to todos_url }
  end
end
```

Or in a model:

```ruby
class Todo < ApplicationRecord
  broadcasts_to ->(todo) { [todo.user, "todos"] }, inserts_by: :prepend
end
```

Using `broadcasts_to ->(todo) { [todo.user, "todos"] }` automatically defines a default behaviour for updating the UI when a new record is created, updated or destroyed. The defaults are as follows and can be overriden:

| Property | Default | Overridable by |
|---|---|---|
| ID of the container to update | `#todos` (model plural) | `target: "all_todos"` |
| Create action | Append to container | `inserts_by: :prepend` |
| Generated partial | `todos/_todo` (model default partial) | `partial: "todos/simple_todo"` |
| Stream name | `[todo.user, "todos"]` | - |

## Custom actions

Updates can also be delivered to a custom container and as a custom callback:

```ruby
class Todo < ApplicationRecord
  after_create_commit :broadcast_later

  private

  def brodcast_later
    broadcast_prepend_later_to user, :todos
  end
end
```

TODO: what's the payload? Same as above, automatically?
