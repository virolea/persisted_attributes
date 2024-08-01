# PersistedAttributes

PersistedAttributes allows to add persisted attributes to ActiveRecord models without the need for a migration.

You might want to add a temporary attribute, for monitoring or reporting purposes, or avoid to pollute your domain tables with marketing-related fields.

With PersistedAttributes, this is as easy as the following:

```ruby
  class User
    include PersistedAttributes::ActiveRecord

    has_persisted_attribute :subscribe_to_newsletter, field_type: :boolean
  end

  user = User.create(subscribe_to_newsletter: true)
  user.subscribe_to_newsletter # => true
```

The declared attribute works seamlessly like a traditionnal ActiveRecord attribute. This means you can use features such as validations without any futher work:

```ruby
class Post
  include PersistedAttributes::ActiveRecord

  has_persisted_attribute :title

  validates :title, presence: true
end

post = Post.new
post.valid? # => false
post.errors.full_messages # => ["Title can't be blank"]
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "persisted_attributes"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install persisted_attributes
```

## Usage

Persisted attributes are backed by the `persisted_attributes_attributes` table. After installing the gem run migrations to add the required tables:

```
rails persisted_attributes:install:migrations
```

Once the migrations are done, start adding attributes to model by including the `PersistedAttributes::ActiveRecord` module any active record model:

```ruby
class Post
  include PersistedAttributes::ActiveRecord
end
```

And voilà! Your model is ready to declare new persisted attributes. The API is as simple as:

```ruby
class Post
  include PersistedAttributes::ActiveRecord

  # Use `has_persisted_attribute` with the field name to declare a new attribute.
  has_persisted_attribute :title

  # Default type for a field is :string. Use the `field_type` option to declare another field type
  has_persisted_attribute :reading_time, field_type: :integer
  has_persisted_attribute :published, field_type: :boolean
end
```

For now, PersistedAttributes allow for three field types;
- String (default)
- Integer
- Boolean

The list will likely grow with time, usage and needs.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
