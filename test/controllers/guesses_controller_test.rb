require 'test_helper'

class GuessesControllerTest < ActionController::TestCase
  test "count correct guesses returns one" do
    # uses fixtures
    assert_equal 1, @controller.send(:countCorrectGuesses)
  end

  test "guess animal returns dog for small height and weight" do
    # uses fixtures
    assert_equal 'dog', @controller.send(:guessPreferredAnimal, 40, 110)
  end

  test "guess animal returns cat for big height and weight" do
    # uses fixtures
    assert_equal 'cat', @controller.send(:guessPreferredAnimal, 80, 210)
  end

end
