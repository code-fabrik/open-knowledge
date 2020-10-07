# Themes

## Terminology

### Template files

* Express how a site is displayed
* Page templates define how Pages are displayed and can be used for multiple pages
* Template Tags are built-in functions to fetch data (such as `the_title()`)
* Template Hierarchy is the logic WP uses to decide what template file to use

Template files are made of HTML and PHP code. Usually, there are files for different
sections of a page called template partials, such as `comments.php` or `header.php`.
The file `index.php` is the fallback if no other template file matched.

The following files are recognized by WP:

* index.php (required) is the main template file
* style.css (required) is the main stylesheet
* front-page.php is used for the start page
* home.php is the default front page and displays the latest posts
* single.php is used for displaying single posts
* page.php is used for displaying single pages
* singular.php is used when page.php and single.php are not found
* header.php, comments.php, etc for the respective section

To include other template files, use functions such as `get_header()`, `get_sidebar()`
and similar.


### style.css

The comment section at the beginning of the style.css file defines data displayed in the
theme settings of the Wordpress backend, such as the name, author, etc.

### Post types

All content in Wordpress is of a specific Post Type. Pages are, and so are posts. Post types
are tied to different template files.
