require 'sinatra/base'
module Market
  extend self
  def contents_of(store)
    require 'open-uri'
    if block_given?
      yield
    end
    open("https://squareup.com/market/#{store}").read
  end
end
module Analyzable
  def prices(text)
    text.scan(/\$([\d\.]+)/).flatten
  end

  def max_price(text)
    all = prices(text)
    all.map do |price|
      price.to_i
    end.reduce(0) do |max_so_far, price|
      [max_so_far, price].max
    end
  end
end
class App < Sinatra::Base
  include Market
  include Analyzable
  get '/' do
    "Hello World"
  end
  get '/:store' do
    max_price(contents_of(params[:store])).inspect
  end
end

App.run!
