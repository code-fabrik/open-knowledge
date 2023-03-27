# Rails Basics

## Getting started

The most important commands in a rails project are the following:

* Install gems: `bundle install`
* Create the database: `rails db:create`
* Run the migrations: `rails db:migrate`
* Store sample data: `rails db:seed`
* Start the server: `rails server`

To generate a new project, run `rails new <projectname>`. This generates an entire project structure, including database config. You can specify `--database=postgresql` to use a specific database engine instead of SQLite.

## Rest

The Rails convention is that for every resource, the following actions and corresponding URLs exist:

* Index: list all items, `GET /posts`
* Show: show one item, `GET /posts/1`
* New: show form for single item, `GET /posts/new`
* Create: form target; create new item, `POST /posts`
* Edit: show form for single item, `GET posts/1/edit`
* Update: form target; create new item, `PUT posts/1`
* Destroy: remove single item, `DELETE posts/1`

## Request flow & Architecture

A request is first handled by the Router file, where URLs are mapped to Controller actions:

<kbd>config/routes.rb</kbd>
```ruby
get '/', to: 'home#index'

resources :posts
```

This routing file defines that requests to the root url should be handled by the `index`-Method of the `HomeController`. Additionally, `resources :name` creates all the REST urls mentioned above for the named resource, and lets the `PostsController` handle them.

You can view all defined routes by running the `rails routes` command.

The controller defines what should happen for an incoming request:

<kbd>app/controllers/posts_controller.rb</kbd>
```ruby
class PostsController < ApplicationController
  def index
    @posts = Post.all()
  end

  def show
    @post = Post.find(params[:id])
  end

  def delete
    post = Post.find(params[:id])
    post.destroy()

    redirect_to(posts_path)
  end
end
```

* Assigning instance variables (`@name`) automatically makes the values available in the templates.
* You can use route params (e.g. `params[:id]`) and query params in your code. To view all available route params, run `rails routes` and look for the placeholders (`:id`).
* Rails autogenerates methods that return urls to navigate the page. Check `rails routes` and append `_path` to the first column of the output to get the corresponding path.

After the controller has run, unless a redirect is defined, Rails automatically renders the corresponding template:

<kbd>app/views/posts/show.html.erb</kbd>
```ruby
<h1><%= @post.title %></h1>
<p><%= @post.content %></p>
```

## Database

The current schema of the database can be seen in <kbd>db/schema.rb</kbd>.

Changes to the database are made using `migrations`, which are instructions on how to change the database state to get to the target schema. Migrations can include

* creation, change and deletion of tables
* creation, change and deletion of columns
* creation, change and deletion of constraints and default values

To generate a migration, run `rails generate migration AddTitleToPosts title:string` to automatically generate a migration adding the title attribute to the posts table.

## Models and ORM

Models are the interface between the application code and the database. They contain definitions of the relationship between tables, so you can query related records in Ruby, while the database is abstracted away.

The component for the ORM is [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html#crud-reading-and-writing-data).


### Creation

| Goal | Method | Example |
|---|---|---|
| Creation (with DB write) | create() | `Post.create(title: 'Test', author: 'Me')` |
| Instanciation (no DB write) | new() | `post = Post.new(title: 'Bla')` |
| Save | save() | `post.save()` |

### Query

| Goal | Method | Example |
|---|---|---|
| All records | all() | `Post.all()` |
| Single record by ID | find() | `Post.find(3)` |
| Single by other attributes | find_by_* | `Post.find_by(title: 'Test', author_name: 'Bla')` |
| Multiple | where() | `Post.where(likes: 12)` |

### Update

| Goal | Method | Example |
|---|---|---|
| Update (with DB write) | update() | `post.update(title: 'Foo')` |
| Update (no DB write) | assignment | `post.title = 'Foo'` |

### Deletion

| Goal | Method | Example |
|---|---|---|
| Single deletion | destroy() | `Post.find(3).destroy()` |
| Bulk deletion | destroy_all() | `Post.destroy_all()` |

You can also query related records, and chain the queries:

`Post.find(3).authors.where('followers > 3')`

Models also contain [validation code](https://guides.rubyonrails.org/active_record_basics.html#validations), where developers can define constraints for the database fields.
