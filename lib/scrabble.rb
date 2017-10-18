require 'pry'

class Scrabble


  def score(word)
    return 0 if word == nil
    tally_points(word)
  end

  def score_letters(word)
    letter_values = []
    word.upcase.chars.each do |letter|
      letter_values << POINT_VALUES[letter]
    end
    letter_values
  end

  def tally_points(word)
    letter_values = score_letters(word)
    score = 0
    letter_values.each do |letter_value|
      score = score += letter_value
    end
    score
  end

  def score_with_multipliers(word, multiplier, word_multiplier = 1)
    letter_values = score_letters(word)
    score = tally_multiplier(letter_values, multiplier) + seven_letter_bonus(word)
    score * word_multiplier
  end

  def tally_multiplier(letter_values, multiplier)
    score = 0
    letter_values.map.with_index do |value, index|
      score = score += (letter_values[index] * multiplier[index])
    end
    score
  end

  def seven_letter_bonus(word)
    if word.length > 6
      10
    else
      0
    end
  end

  def highest_scoring_word(words)
    word_scores = tally_each_word(words)
    highest_score_index = find_index_of_highest_scoring_words(word_scores)
    high_scoring_words = find_all_highest_scoring_words(highest_score_index, words)
    find_high_score_with_lowest_tiles(high_scoring_words)
  end

  def tally_each_word(words)
    word_scores = []
    words.each do |word|
      word_scores << tally_points(word)
    end
    word_scores
  end

  def find_index_of_highest_scoring_words(word_scores)
    highest_score_index = []
    word_scores.each_with_index do |score, index|
      if score == word_scores.max
        highest_score_index << index
      end
    end
    highest_score_index
  end

  def find_all_highest_scoring_words(highest_score_index, words)
    highest_score_index.map! do |index|
      words[index]
    end
  end

  def find_high_score_with_lowest_tiles(high_scoring_words)
    high_scoring_words.min_by do |word|
      word.length
    end
  end


  POINT_VALUES =
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }

end
