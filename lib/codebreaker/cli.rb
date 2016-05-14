$LOAD_PATH << File.dirname(__FILE__)
require 'game'
require 'yaml'

module Codebreaker
  class Cli
    include Codebreaker
    attr_accessor :game
    def initialize
      @game = Game.new
    end

    def play
      @game.start
      while @game.turns > 0
        puts "Write a guess:"
        puts @game.check_guess(gets.chomp)
        break if @game.win
        suggest_hint
      end
      puts @game.win ? "You win!" : "You lose. Secret code is #{@game.secret_code}!"
      save_score
      play_again
    end

    def suggest_hint 
      puts "Do you want a hint (y/n)?" if @game.hints > 0   
      puts "Number: #{ @game.hint }\n#{@game.hints} left." if gets.chomp == "y"
    end

    def play_again
      puts "Do you want play again (y/n)?"
      if gets.chomp == "y"
        @game = Game.new
        play
      end
    end

    def save_score
      puts "Do you want save score (y/n)?"
      if gets.chomp == "y"
        puts "What is your name?"
        save(@game.get_score(gets.chomp))
      end
    end

    private
      def save(data)
        File.open("score.yml", "a") { |file| file.write data.to_yaml }
      end
  end
end