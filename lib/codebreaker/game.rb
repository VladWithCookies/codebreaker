module Codebreaker
  class Game
    attr_accessor :turns
    attr_accessor :win
    attr_accessor :secret_code
    attr_accessor :hints
    
    NUM_OF_HINTS = 5
    NUM_OF_TURNS = 10

    def initialize
      @secret_code = ""
      @turns = NUM_OF_TURNS
      @win = false
      @hints = NUM_OF_HINTS
    end

    def start
      4.times { @secret_code << Random.new.rand(1..6).to_s }
    end

    def check_guess(guess)
      @turns -= 1
      result = ""
      code = @secret_code.chars
      g = guess.chars
      guess.chars.each_with_index do |x, i| 
        if x == @secret_code[i]
          result << "+"
          g.delete(x) 
          code.delete(x)
        end
      end
      g.each { |x| result << "-" if code.include? x}
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
        turns: NUM_OF_TURNS - @turns,
        hints: NUM_OF_HINTS - @hints,
        date: Time.now
      }
    end
  end
end