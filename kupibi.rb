require 'em-hiredis'
require 'hiredis'
require "sinatra/base"
require 'sinatra/json'
require 'sinatra/config_file'
require 'json'

require './lib/shortener_converter'
require './lib/redis_storage'

class Kupibi < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.yml'

  get '/' do
    json url: url_to(shortener.short_url_for(params[:url]))
  end

  get '/:code' do
    url = shortener.long_url_for(params[:code])

    if url
      redirect url, 301
    else
      not_found
    end
  end

  def shortener
    @shortener ||= ::ShortenerConverter.new
  end

  # TODO: move to helpers
  def url_to(path)
    [request.base_url, path].join('/')
  end

end


