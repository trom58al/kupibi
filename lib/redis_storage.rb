# TODO: separate it to 2 classes
class RedisStorage

  SHORTENER_URL_PREFIX = "shortener.url_for"

  def initialize(options = {})
    @em_hiredis = options.fetch(:em_hiredis) { ::EM::Hiredis.connect }
    @hiredis = options.fetch(:hiredis) { ::Hiredis::Connection.new }
    @hiredis.connect(host, port)
  end

  def publish(code, url)
    em_hiredis.publish("new_url", { code: code, url: url }.to_json)
  end

  def set_url(code, value)
    hiredis.write ["SET", shortener_url_key(code), value]
    hiredis.read
  end

  def url(code)
    hiredis.write ["GET", shortener_url_key(code)]
    hiredis.read
  end

  private

  attr_reader :em_hiredis, :hiredis

  def shortener_url_key(code)
    "#{SHORTENER_URL_PREFIX}.#{code}"
  end

  def host
    settings["host"]
  end

  def port
    settings["port"]
  end

  def settings
    ::Kupibi.settings.redis
  end

end