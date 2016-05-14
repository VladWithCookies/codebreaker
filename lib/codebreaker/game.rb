module Codebreaker
  class Game
    attr_accessor :turns
    attr_accessor :win
    attr_accessor :secret_code
    attr_accessor :hints
    
    def initialize
      @secret_code = ""
      @turns = 10
      @win = false
      @hints = 5
    end

    def start
      4.times { @secret_code << Random.new.rand(1..6).to_s }
    end

    def check_guess(guess)
      @turns -= 1
      result = ""
      guess.chars.each_with_index do |x, i| 
        if x == @secret_code[i]
          result << "+"
        elsif @secret_code.include? x
          result << "-"
        end
      end
      @win = true if result == "++++"
      return result
    end

    def hint
      @hints -= 1
      @secret_code[Random.new.rand(0..3)]
    end

    def get_score(username)
      {
        name: username,
        win: @win,
        turns: 10 - @turns,
        hints: 5 - @hints,
        date: Time.now
      }
    end
  end
end


