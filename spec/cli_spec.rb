require 'spec_helper'

module Codebreaker
  RSpec.describe Cli do
    subject(:cli) { Cli.new }
    let(:game) { cli.game }

    before do
      allow(cli).to receive(:gets).and_return("1234")
      game.instance_variable_set(:@secret_code, "4321")
    end

    describe "#play" do
      it "puts win massage if codebreaker win" do
        game.win = true
        expect { cli.play }.to output(/You win!/).to_stdout
      end

      it "puts lose message if codebreaker lose" do
        game.turns = 0
        expect { cli.play }.to output(/You lose./).to_stdout
      end

      it "give a hint if user type 'hint'" do 
        allow(cli).to receive(:gets).and_return("hint")
        expect {cli.play}.to output(/\b[1-4]/).to_stdout
      end

      it "puts suggestion to play again when game over" do
        game.win = true
        expect { cli.play }.to output(/want play again/).to_stdout
      end

      it "puts suggestion to save a score when game over" do
        game.win = true
        expect { cli.play }.to output(/want save score/).to_stdout
      end

    end

    describe "#save_score" do
      it "ask to save user name" do 
        allow(cli).to receive(:gets).and_return("y")       
        expect { cli.save_score }.to output(/your name/).to_stdout
      end
    end

  end
end
