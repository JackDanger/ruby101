#!/usr/bin/env bundle exec shotgun
require 'sinatra'
require 'feminizer'

require 'open-uri'
class Analyzer
  def initialize(url)
    @url = url
  end

  def html
    @html ||= open(@url).read
  end

  def all_words
    html.split(' ').select do |word|
      word =~ /^[a-zA-Z-]+$/
    end
  end

  def unique_words
    word_count = {}
    all_words.each do |word|
      word_count[word] ||= 0
      word_count[word] += 1
    end
    word_count.map do |word, count|
      word if count == 1
    end
  end

  def feminize
    Feminizer.feminize_html(html)
  end
end

get "/rarewords" do
  "<form action='/rarewords' method='post'>
  <label for='name'>Enter a url</label>
  <input type='text' name='url' />
  <input type='submit'>
  </form>"
end

post "/rarewords" do
  analyzer = Analyzer.new(params[:url])
  analyzer.unique_words.join(' ')
end

get "/feminize" do
  "<form action='/feminize' method='post'>
  <label for='name'>Enter a url</label>
  <input type='text' name='url' />
  <input type='submit'>
  </form>"
end

post "/feminize" do
  analyzer = Analyzer.new(params[:url])
  analyzer.feminize
end
