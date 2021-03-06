module Codebreaker
  class Game
    attr_accessor :turns
    attr_accessor :win
    attr_accessor :secret_code
    attr_accessor :hints
    
    NUM_OF_HINTS = 1
    NUM_OF_TURNS = 10

    def initialize
      @secret_code = ""
      @turns = NUM_OF_TURNS
      @win = false
      @hints = NUM_OF_HINTS
    end

    def start
      @secret_code = (1..4).map { rand(1..6) }.join
    end

    def check_guess(guess)
      if guess == @secret_code
        @win = true
        return "++++"
      end
      @turns -= 1
      result = ""
      code_chars, guess_chars = @secret_code.chars, guess.chars
      guess_chars_copy = guess.chars
      guess_chars_copy.each_with_index do |x, i| 
        next unless x == @secret_code[i]
        result << "+"
        delete_at_both(code_chars, guess_chars, x)
      end
      guess_chars_copy.each do |x|  
        next unless code_chars.include? x
        result << "-"
        delete_at_both(code_chars, guess_chars, x) 
      end 
      return result
    end

    def hint
      @hints -= 1
      @secret_code[rand(0..3)]
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
    private
      def delete_at_both(a, b, x)
        a.delete(x)
        b.delete(x)
      end
  end
end