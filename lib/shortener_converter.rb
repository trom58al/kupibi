class ShortenerConverter

  def initialize(options = {})
    @storage = options.fetch(:storage) { ::RedisStorage.new }
  end

  def short_url_for(url)
    code = generate_code
    storage.publish(code, url)
    code
  end

  def long_url_for(code)
    storage.url(code)
  end

  def generate_code
    symbols = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    code = (0...7).map { symbols[rand(symbols.length)] }.join
    code_uniq?(code) ? code : generate_code
  end

  private

  attr_reader :storage

  def code_uniq?(code)
    true
  end

end