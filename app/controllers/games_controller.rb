require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # display a new random grid and a form
    # the form will be submitted (with POST) to the score action
    @letters = ('a'..'z').to_a.sample(12)
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word]
    @included = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    words = JSON.parse(word_serialized)

    @valid = words['found']
  end
end
