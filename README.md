# Transpose
Simple object transpositions using hash map of attributes. Particularly useful when working with remote apis,
and mapping from a remote structure, to a localized structure.

### Example

You want to map a remote post model with mostly camel cased method names, to a local active record model.

``` ruby
class RemotePost < ::OpenStruct
  include ::Transpose::Transposable

  transposer "Post", {
    :Id => :remote_id,
    :Title => :title,
  }
end
```

And back again

``` ruby
class Post < ::ActiveRecord::Base
  include ::Transpose::Transposable

  transposer "RemotePost", {
    :remote_id => :Id,
    :title => :Title
  }
end
```

So you do

``` ruby
remote = ::RemotePost.new(:Id => '1234', :Title => "Nocturne In e Flat Op 9 No.2" )
local = remote.transpose(Post).save
#=> #<Post id="1234", title="Nocturne In e Flat Op 9 No.2">
```

### Transposing already initialized instances

Supports passing an instance as well via transpose_instance

``` ruby
post = Post.new(:title => "prebuilt title")
remote_post = ::RemotePost.new(:Id => 1234)
remote_post.transpose_instance(post)
#=> #<Post id="1234", title="prebuilt title">
```

### Roadmap
1. Implementing a good solution for working with external api gems, when classes
have already been defined. I.E. abstracting injecting the transposer into remote model.

2. **Maybe** support for getter and setter value strategies, i.e. right now you
cant map an object to a hash, since it sets/gets via send.
However, Im not sure that should be a concern of this gem, as that would likely
kill much of the simplicity which Id like to keep.

3. **Maybe** coercion of attributes via passing lambda as value

## Installation

Add this line to your application's Gemfile:

    gem 'transpose'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transpose

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/transpose/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
