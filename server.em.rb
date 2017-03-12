# TODO: write/use own config and delete this require
require './kupibi'
require 'em-hiredis'
require 'hiredis'
require 'json'

require './lib/shortener_converter'
require './lib/redis_storage'

EM.run do

  redis = EM::Hiredis.connect

  redis_storage = RedisStorage.new(redis: redis)

  redis.pubsub.subscribe("new_url") do |json|
    # Imitation something long
    sleep 2

    data = JSON.parse(json)

    code = data["code"]
    url = data["url"]

    redis_storage.set_url(code, url)
  end

end
