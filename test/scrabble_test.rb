gem 'minitest'
require_relative '../lib/scrabble'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ScrabbleTest < Minitest::Test

  def test_it_exists
    game = Scrabble.new

    assert_instance_of Scrabble, game
  end

  def test_it_can_score_a_single_letter

    assert_equal 1, Scrabble.new.score("a")
    assert_equal 4, Scrabble.new.score("f")
  end

  def test_it_can_score_a_whole_word

    assert_equal 8, Scrabble.new.score("hello")
    assert_equal 8, Scrabble.new.score("SwEeT")
  end

  def test_it_can_score_an_empty_string
    assert_equal 0, Scrabble.new.score("")
  end

  def test_it_can_score_a_nil_string
    assert_equal 0, Scrabble.new.score(nil)
  end

  def test_it_can_score_letter_multiplier
    game = Scrabble.new

    assert_equal 9, game.score_with_multipliers('hello', [1,2,1,1,1])
  end

  def test_it_can_score_word_multiplier
    game = Scrabble.new

    assert_equal 18, game.score_with_multipliers('hello', [1,2,1,1,1], 2)
  end

  def test_it_can_score_7_letter_bonus
    game = Scrabble.new

    assert_equal 58, game.score_with_multipliers('sparkle', [1,2,1,3,1,2,1], 2)
  end

  def test_finds_highest_scoring_word
    game = Scrabble.new

    assert_equal 'home', game.highest_scoring_word(['home', 'word', 'hello', 'sound'])
  end

  def test_finds_highest_scoring_word_choose_fewest_tiles
    game = Scrabble.new

    assert_equal 'word', game.highest_scoring_word(['hello', 'word', 'sound'])
  end
end
