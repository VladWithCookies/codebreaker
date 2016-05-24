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
        case answer = gets.chomp
          when /^[1-6]{4}$/
            check_guess(answer)
          when "hint" 
            hint
          else
            puts "Invalid code!"
          end
        break if @game.win
      end
      puts @game.win ? "You win!" : "You lose. Secret code is #{@game.secret_code}!"
      save_score
      play_again
    end

    def hint 
      return "No more hints =(" if @game.hints == 0
      puts "Secret code contain #{ @game.hint }.\n#{@game.hints} left."
    end

    def play_again
      puts "Do you want play again (y)?"
      return unless gets.chomp == "y"
      @game = Game.new
      play
    end

    def save_score
      puts "Do you want save score (y)?"
      return unless gets.chomp == "y"
      puts "What is your name?"
      save(@game.get_score(gets.chomp))
    end

    def check_guess(guess)
      puts @game.check_guess(guess)
    end

    private
      def save(data)
        File.open("score.yml", "a") { |file| file.write data.to_yaml }
      end
  end
end