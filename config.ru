
module Greeter
  def self.included(target)
    target.get '/:name' do
      "greetings from Greeter to you #{params[:name]} [#{target}]"
    end
  end
end

require 'sinatra/base'
class App < Sinatra::Base

  include Greeter

end

run App
