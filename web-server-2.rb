#!/usr/bin/env bundle exec shotgun
require 'sinatra'

get "/" do
  "<form action='/' method='post'>
  <label for='name'>Enter your name</label>
  <input type='text' name='name' />
  <input type='submit'>
  </form>"
end

post '/' do
  "Hello, #{params[:name]}"
end

get "/:name" do
  "You're asking for #{params[:name]}"
end
