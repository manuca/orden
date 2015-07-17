# Orden

A simple library (~ 40 LOC) to generate sorting links on query strings via
query string of the type: `http://www.example.com/?sort_attr=id&sort_dir=asc`.

The only dependency of this library is *Rack* so it should work in your Rack
compatible framework of choice (Cuba, Rails, Roda, Sinatra, etc).

The typical use case for the library is column sorting on html tables.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'orden'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install orden

## Usage

You need to instantiate an `Orden` object in the context of the current
request, for this you need to pass a Rack::Request or similiar (Roda request
object).

```ruby
Orden.new([request_object], [default sort attr], [default order (asc/desc)])
```

For example:

```ruby
@sorter = Orden.new(r, "id", "desc")
```

In your views you can now call:

```ruby
@sorter.sort_path([attr])
```

For example in a table header:

```eruby
<th><a href="<%= @sorter.sort_path "id" %>">ID</a></th>
<th><a href="<%= @sorter.sort_path "name" %>">Name</a></th>
```

and it will generate the expected path to sort your results using that
attribute for example (/users?sort_attr=id&sort_dir=asc).

## Security

Take into account that this library does not apply any type of sanitation to
the received parameters. Typically sorting attributes should be filtered or
white listed someway before applying them to an SQL query or equivalent.

For example you can create a helper such as:

```ruby
module SortHelper
  def sort_sql(sorter, attr_whitelist)
    if attr_whitelist.include?(sorter.current_attribute)
      "#{sorter.current_attribute} #{sorter.current_direction}"
    else
      "#{sorter.default_attr} #{sorter.default_dir}"
    end
  end
end
```

and the use it in an ActiveRecord query:

```ruby
@sorter = Orden.new(req, "id", "desc")
@users = User.order(sort_sql(@sorter, User::SORTABLE_ATTRIBUTES)).
```

Please take this as an example, this code may not be secure.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/manuca/orden.
