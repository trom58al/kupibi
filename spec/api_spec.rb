require 'rspec'
require 'rack/test'
require "./kupibi"
require "json"

describe Kupibi do
  include Rack::Test::Methods

  def app
    Kupibi
  end

  let(:storage_class) { double("StorageClass") }
  let(:storage) { double("Storage") }

  before {
    storage.stub(:publish)
    storage_class.stub(:new).and_return(storage)
  }

  it "generate short url" do
    stub_const("RedisStorage", storage_class)

    post "/", url: "http://test.site"
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)["url"]).to be
  end

  context "when url was cached" do

    before { storage.stub(:url).and_return("http://some.url") }

    it "301 redirect to long url" do
      stub_const("RedisStorage", storage_class)

      get "/xAW123d"
      expect(last_response.status).to eq 301
    end

  end

  context "when url wasn't cached" do

    before { storage.stub(:url) }

    it "page not found" do
      stub_const("RedisStorage", storage_class)

      get "/xAW123d"
      expect(last_response.status).to eq 404
    end

  end

end
