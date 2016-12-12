require 'test_helper'

class GuessTest < ActiveSupport::TestCase
  test "should not save guess without height, weight and guess value" do
    guess = Guess.new
    assert_not guess.save
  end

  test "should not save guess with non-numeric height or weight" do
    guess = Guess.new
    guess.height = 'test'
    guess.weight = 'abc123'

    assert_not guess.save
  end

  test "should not save guess with invalid pet type" do
    guess = Guess.new
    guess.height = 55
    guess.weight = 156
    guess.guessvalue = 'llama'

    assert_not guess.save
  end
end
