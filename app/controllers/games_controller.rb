require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    generate = ('A'..'Z').to_a
    @letters = generate.sample(10)
  end

  def score
    def included?(word, grid)
      word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
    end

    def existing?(word)
      response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      return json['found']
    end

    def check
      if included?(params[:word].upcase, params[:letters])
        if existing?(params[:word])
          @resultat = "Bravo ! #{params[:word]} est validé !"
        else
          @resultat = "Désolé, mais #{params[:word]} n'est pas un mot validé par le dictionnaire"
        end
      else
        @resultat = "Désolé mais le mot #{params[:word]} n'utilise pas les lettres #{params[:letters]}"
      end
    end
    check
  end
end
