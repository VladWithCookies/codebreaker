$LOAD_PATH << File.dirname(__FILE__)
require 'game'
require 'yaml'

class Cli
  include Codebreaker
  def initialize
    @game = Game.new
  end

  def play
    @game.start
    while @game.turns > 0
      puts "Write a guess:"
      guess = gets.chomp
      puts @game.check_guess(guess)
      break if @game.win
      suggest_hint
    end
    puts @game.win ? "You win!" : "You lose. Secret code is #{@game.secret_code}!"
    save_score
    play_again
  end

  def suggest_hint 
    puts "Do you want a hint (y/n)?" if @game.hints > 0
    answer = gets.chomp
    if answer == "y"
      puts "Write number:"
      number = gets.chomp
      puts "#{number} is on #{@game.hint(number)} position"
      puts "#{@game.hints} left."
    end
  end

  def play_again
    puts "Do you want play again (y/n)?"
    answer = gets.chomp
    if answer == "y"
      @game = Game.new
      play
    end
  end

  def save_score
    puts "Do you want save score (y/n)?"
    answer = gets.chomp
    save(@game.get_score) if answer == "y"
  end

  def save(data)
    File.open("./../../db/score.yml", "a") { |file| file.write data.to_yaml }
  end
end

Cli.new.play




