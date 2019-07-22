require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    # @letters = []
    # @letters << ("a".."z").to_a.sample
    # @letters = Array.new(7) { ("A".."Z").to_a.sample }
    @letters = Array.new(4) { VOWELS.sample }
    @letters += Array.new(6) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letter)
    word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    # check all letters in my word exist inside my letters array
    # if true then check that it is less than or equal to letters.
    # otherwise it false
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = JSON.parse(open(url).read)
    json['found']
  end
end

# The word can't be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
