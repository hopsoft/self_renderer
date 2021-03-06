[![Lines of Code](http://img.shields.io/badge/lines_of_code-33-brightgreen.svg?style=flat)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](http://img.shields.io/codeclimate/github/hopsoft/self_renderer.svg?style=flat)](https://codeclimate.com/github/hopsoft/self_renderer)
[![Dependency Status](http://img.shields.io/gemnasium/hopsoft/self_renderer.svg?style=flat)](https://gemnasium.com/hopsoft/self_renderer)

# SelfRenderer

Rails model & object rendering outside the context of web requests.

## Use Cases

* Serialize model in background job to send over ActionCable
* etc....

## Quick Start

```ruby
# Gemfile
gem "self_renderer"
```

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include SelfRenderer
end
```

```erb
<!-- app/views/users/show.html.erb -->
<h1>User</h1>
<%= render "item" %>
```

```erb
<!-- app/views/users/_item.html.erb -->
<p><%= @user.name %></p>
```

```ruby
# app/views/users/show.json.jbuilder
json.partial! "item"
```

```ruby
# app/views/users/_item.json.jbuilder
json.name @user.name
```

```ruby
# render html strings
User.find(1).render_with(template: "users/show.html")
User.find(2).render_with(partial: "users/item.html")

# render json strings
User.find(3).render_with(template: "users/show.json")
User.find(4).render_with(partial: "users/item.json")

# render ruby hashes
User.find(5).render_to_hash(template: "users/show.json")
User.find(6).render_to_hash(partial: "users/item.json")
```


