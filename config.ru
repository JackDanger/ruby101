#run proc {
#  [200,
#   {'Content-Type' => 'text/html'},
#   ['Hello, world!']
#  ]
#}

run proc {
  who_I_am = "The Awesome Possum"
  current_time = Time.now
  my_html = "<p> <strong>#{who_I_am}</strong> #{current_time}"
  [200,
   {'Content-Type' => 'text/html'},
   [my_html]
  ]
}
