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
  def self.configure(&block) : Nil
    yield config
  end

  class Configuration
    property endpoint : String = "https://pubsubhubbub.appspot.com/subscribe"
    property callback : URI = URI.parse("https://127.0.0.1/")
    property useragent : String = "PubSubHubbub.cr/#{VERSION}"

    def callback=(string : String)
      @callback = URI.parse string
    end
  end
end
