# PubSubHubbub.cr

PubSubHubbub subscriber library written in Crystal.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     pubsubhubbub:
       github: joseafga/pubsubhubbub.cr
   ```

2. Run `shards install`

## Usage

### Basic

```crystal
require "pubsubhubbub"

PubSubHubbub.configure do |settings|
  settings.host = "https://www.example.com"
  settings.path = "/pubsubhubbub/some/path"
end

subscriber = PubSubHubbub::Subscriber.new "https://www.youtube.com/xml/feeds/videos.xml?channel_id=SomeChannelId"
subscriber.subscribe
```

### HTTP Server

Basic usage allows sending requests to the server but new requests will be sent to the host address (configured in `PubSubHubbub.configure`) and will expect a specific response. To deal with this, we will need an `HTTP::Server`, fortunately `PubSubHubbub.cr` already has a handler created to be used together with `HTTP::Server`, which should provide the necessary functions for the most of use cases.

```crystal
require "pubsubhubbub"
require "http"

class MyClass
  class_getter subscriber = PubSubHubbub::Subscriber.new("https://www.youtube.com/xml/feeds/videos.xml?channel_id=SomeChannelId")

  # `SubscriberHandler` uses to handle incoming requests from Hub.
  # This is used to make more dynamic, so that it is possible to find a value from an array or
  # database.
  def self.find_subscriber!(topic : String?) : PubSubHubbub::Subscriber
    subscriber
  end
end

# This hook will execute when it receives a notification.
PubSubHubbub::Subscriber.on :notify do |subscriber, xml|
  puts "Receiving notification from #{subscriber.topic}: #{xml}"
end

server = HTTP::Server.new([
  PubSubHubbub::ErrorHandler.new,
  PubSubHubbub::SubscriberHandler(MyClass).new,
])

address = server.bind_tcp 8080
puts "Listening on http://#{address}"
server.listen
```

## Contributing

1. Fork it (<https://github.com/joseafga/pubsubhubbub.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [José Almeida](https://github.com/joseafga) - creator and maintainer
