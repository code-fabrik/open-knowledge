# Turbo

## Turbo Drive

Turbo Drive is mostly what Turbolinks was earlier. Link clicks and form submissions are automatically intercepted, and **instead of a full page load, Turbo loads the target using `fetch` and replaces the `<body>` element**. This prevents the browser from needing to reparse CSS and JS resources.

To disable Drive for a single element (a link or a form), annotate it with `data-turbo="false"`.

## Turbo Frames

Turbo Frames allows developers to **replace only parts of a page when the user clicks a link or submits a form**. This can be used to show an inline form in a list of editable items.

To use turbo frames, use the `turbo_frame_tag` helper and pass the ActiveRecord entity to the helper:

`todos/index.html.erb`

```erb
<% @todos.each do |todo| %>
  <%= turbo_frame_tag todo do %>
    <div><%= todo.title %> <%= link_to 'edit', edit_todo_path(todo) %></div>
  <% end %>
<% end %>
```

All navigations that lead to a page containing the same tag will automatically be injected into the existing frame. Note however, that Rails still renders the entire template, and the frontend JS extracts the tag and inserts it into the appropriate place. This might have performance implications if the page is particularly expensive to generate.

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

⚠ The target page must always include the `turbo_frame_tag`, otherwise an error message ("Content missing") will be displayed.

## Turbo Streams

Streams are used to **replace parts of a website after a user action**. In addition to the `Frames` above, they can be used to

* replace other parts of the website as well, not only the part where the user action occured (e.g. to add a new list item when the user submitted a form)
* broadcast those changes to other users via WebSockets

Contrary to the `Frames`, `Streams` only render the part to replace, and not the whole page. This can make rendering a lot faster, if the part of the website to update is small and the whole page is large.

To deliver an update from the backend, you can choose how the update should be treated on the frontend. You can either append or prepend a new item to a container, you can replace an existing item (losing all event handlers of the item), update the content of an existing item (keeping the handlers of the item), remove an item, or add an item before or after a specific other item.

### Local updates

To update a part of a website in response to a user action, add a `turbo_stream` format handler to the controller action:

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

For the create action, this automatically renders `todos/todo` with the `todo` local variable and appends it to the element with id "todos". Note that the following calls are equivalent, but `partial`  and `locals` can be customized:

* `turbo_stream.append(:todos, partial: "todos/todo", locals: { todo: todo })`
* `turbo_stream.append(:todos, todo)`

For the delete action, this automatically removes the element with the `dom_id(todo)`. Instead of a model (on which `to_key()` is called), it's also possible to pass a specific DOM id.

It is also possible to apply multiple updates by passing an array like `[turbo_stream.remove(todo), turbo_stream.update(notification)]`

### Broadcasts

To broadcast changes, visitors must subscribe to a specific channel in order to get the updates. This allows developers to scope the updates to specific topics or specific (authorized) users.

To subscribe to a stream on the frontend, use the `turbo_stream_from` tag and pass an identifier.

`todos/index.html.erb`

```erb
<%= turbo_stream_from "todos" %>
```

Any user subscribing to the same stream will get all updates to this stream.

It is also possible to scope a stream more narrowly, by passing multiple identifiers:

```erb
<%= turbo_stream_from current_user, "todos" %>
```

The stream name is derived from all arguments to the `turbo_stream_from` call. That means that messages are now scoped to the user.

Updates can be either sent as a result of a model change:

```ruby
class Todo < ApplicationRecord
  broadcasts_to ->(todo) { [todo.user, "todos"] }
end
```

or in a controller, by custom code:

```ruby
def create
  ...
  @todo.broadcast_append_later_to(current_user, "todos")
  ...
end
```

This instructs Rails to broadcast all updates to the users subscribed to the channel `{user}, "todos"`. The model call to `broadcasts_to` automatically defines a default behaviour for updating the UI when a new record is created (calling `append`), updated (calling `replace`) or destroyed (calling `remove`). For the controller broadcasts, the action must be specified in the broadcast call. The defaults are as follows and can be overriden:

| Property | Default | Overridable by |
|---|---|---|
| ID of the container to update | `#todos` (model plural) | `target: "all_todos"` |
| Create action | Append to container | `inserts_by: :prepend` |
| Generated partial | `todos/_todo` (model default partial) | `partial: "todos/simple_todo"` |
| Stream name | `[todo.user, "todos"]` | - |

## Custom model actions

Model updates can also be delivered at any other time in the lifecycle and by applying a custom action:

```ruby
class Todo < ApplicationRecord
  after_create_commit :broadcast_later

  private

  def brodcast_later
    broadcast_prepend_later_to user, :todos
  end
end
```

The payload is the partial derived from the model name (`todos/todo`) and will be prepended to the DOM element which has the plural name of the model as the ID (`todos`).
