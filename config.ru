require 'sinatra/base'

module Market
  def store_url(name)
    "https://squareup.com/market/#{name}"
  end

  def contents_of(name)
    require 'open-uri'
    open(store_url(name)).read
  end
end

module ItemAnalysis
  def prices(text)
    text.scan(/\$(\d+\.?\d?\d?)/).flatten
  end

  def average_price(text)
    all = prices(text)
    all.reduce(0) {|sum, price| sum += price.to_f } / all.size
  end
end

class App < Sinatra::Base

  include ItemAnalysis
  include Market

  get '/' do
    "Type a market business name into the url"
  end

  get '/:stores' do
    html = "<h1>Prices:</h1>"
    params[:stores].split(',').each do |store|
      html += "#{store}: $#{average_price(contents_of(store)).to_i} <br />"
    end
    html
  end

end

run App
