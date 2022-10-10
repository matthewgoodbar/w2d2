class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    return DICTIONARY.sample
  end

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    return @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    res = []
    @secret_word.each_char.with_index {|c, i| res << i if char == c}
    return res
  end

  def fill_indices(char, arr)
    arr.each{|i| @guess_word[i] = char}
  end

  def try_guess(char)
    if already_attempted?(char)
      puts "that has already been attempted"
      return false
    end
    indices = get_matching_indices(char)
    @attempted_chars << char
    if indices.length == 0
      @remaining_incorrect_guesses -= 1
    else
      fill_indices(char, indices)
    end
    return true
  end

  def ask_user_for_guess
    puts "Enter a char: "
    user_input = gets.chomp
    return try_guess(user_input)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    end
    return false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    return false
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      return true
    end
    return false
  end

end
