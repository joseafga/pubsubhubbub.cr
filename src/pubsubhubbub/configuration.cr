require "uri"

module PubSubHubbub
  class_getter config = Configuration.new

  # Customize default settings using block.
  #
  # ```
  # PubSubHubbub.configure do |config|
  #   config.callback = "https://example.com/some/path"
  # end
  # ```
  def self.configure(&) : Nil
    yield config
  end

  class Configuration
    property endpoint : String = "https://pubsubhubbub.appspot.com/subscribe"
    property callback : URI = URI.new
    property useragent : String = "PubSubHubbub.cr/#{VERSION}"

    def callback=(string : String)
      @callback = URI.parse string
    end
  end
end
