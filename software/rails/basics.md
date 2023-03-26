# Rails Basics

## Getting started

* Install gems: `bundle install`
* Create the database: `rails db:create`
* Run the migrations: `rails db:migrate`
* Store sample data: `rails db:seed`
* Start the server: `rails server`

## Rest

* Index: list all items, `GET /posts`
* Show: show one item, `GET /posts/1`
* New: show form for single item, `GET /posts/new`
* Create: form target; create new item, `POST /posts`
* Edit: show form for single item, `GET posts/1/edit`
* Update: form target; create new item, `PUT posts/1`
* Destroy: remove single item, `DELETE posts/1`

## Request flow & Architecture

Router (`config/routes.rb`) -> Controller (`app/controllers/x_controller.rb`) -> View (`app/views/x/action.html.erb`)

* List routes with `rails routes`
* `resource :name` creates all 7 routes described above
* Nesting routes nests the urls, e.g. `/posts/1/comments`
* Request is passed to controller with same name as route
* View with same name as controller is automatically rendered

## Database

The current schema of the database can be seen in `db/schema.rb`.

Changes to the database are made using `migrations`, which are instructions on how to change the database state
to get to the target schema. Migrations can include

* creation, change and deletion of tables
* creation, change and deletion of columns
* creation, change and deletion of constraints and default values

To generate a migration, run `rails generate migration AddTitleToPosts title:string` to automatically generate a
migration adding the title attribute to the posts table.