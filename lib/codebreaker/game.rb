module Codebreaker
  class Game
    attr_accessor :turns
    attr_accessor :win
    attr_accessor :secret_code
    attr_accessor :hints
    
    def initialize
      @secret_code = ""
      @turns = 10
      @win = false@hints = 3
    end

    def start
      rnd = Random.new
      4.times { @secret_code << rnd.rand(1..6).to_s }
    end

    def check_guess(guess)
      @turns -= 1
      result = ""
      guess.chars.each_with_index do |x, i| 
        if x == @secret_code[i]
          result << "+"
        elsif @secret_code.include? x
          result << "-"
        else
          result << "."
        end
      end
      @win = true if result == "++++"
      return result
    end

    def hint(number) 
      @hints -= 1
      @secret_code.index(number) + 1
    end

    def get_score
      {
        win: @win,
        turns_left: @turns,
        hints_left: @hints,
        date: Time.now
      }
    end
  end
end


