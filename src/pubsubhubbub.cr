require "log"
require "./pubsubhubbub/**"

# Client and server for PubSubHubbub protocol
#
# NOTE: http://pubsubhubbub.github.io/PubSubHubbub/pubsubhubbub-core-0.4.html
module PubSubHubbub
  VERSION = "0.1.5"
  Log     = ::Log.for("pubsubhubbub")

  class ChallengeError < Exception
  end

  class NotificationError < Exception
  end
end
