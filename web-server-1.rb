#!/usr/bin/env bundle exec shotgun

# Once this file is running you can type this into your terminal to see it!
# nc localhost 9393
# GET / HTTP/1.1
# [hit enter]
# GET /otherpage HTTP/1.1
# [hit enter]

require 'sinatra'

get "/" do
  who_I_am = "The Awesome Possum"
  current_time = Time.now
  "<p> <strong>#{who_I_am}</strong> #{current_time}"
end


get "/otherpage" do
  "Another page!"
end
