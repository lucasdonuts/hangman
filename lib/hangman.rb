require_relative 'word.rb'
require_relative 'noose.rb'

def get_dictionary
  file = File.open("dictionary.txt")
  dictionary = file.read.split("\r\n")
  dictionary = dictionary.delete_if { |word| word.length > 12 || word.length < 5 }
end

class Hangman

  def initialize(dictionary)
    puts "Welcome to Hangman. You have 6 incorrect guesses."
    @chances = 6
    @noose = Noose.new
    @dictionary = dictionary
    @word = Word.new(@dictionary)
    @noose.display_noose(@chances)
    @letters_guessed = []
    turn
  end

  def turn
    puts "\n"
    @word.display_blanks
    @letters_guessed.sort!
    puts @letters_guessed.nil? ? "Letters guessed: None" : "Letters guessed: #{@letters_guessed.join(" ")}"
    @guess = get_guess
    check_guess
    puts "\n\n"
  end

  def get_guess
    print "Guess a letter: "
    guess = gets.chomp.downcase
  end

  def check_guess
    if @letters_guessed.include?(@guess)
      puts "You already tried that one!"
      @noose.display_noose(@chances)
      turn
    elsif (@word.letter_in_word?(@guess))
      @letters_guessed.push(@guess)
      @noose.display_noose(@chances)
      @word.update_blanks(@guess)
      if @word.word_complete?
        @word.display_blanks
        display_message("victory")
        if play_again?
          Hangman.new(@dictionary)
        else
          exit
        end
      else
        display_message("correct")
        turn
      end
    else
      @letters_guessed.push(@guess)
      @chances -= 1
      @noose.display_noose(@chances)
      if @chances == 0
        display_message("game over")
        if play_again?
          Hangman.new(@dictionary)
        else
          exit
        end
      else
        display_message("incorrect")
        turn
      end
    end
  end

  def play_again?
    puts "Would you like to play again? (y/n)"
    answer = gets.chomp
    answer == "y" ? true : false
  end

  def display_message(message)
    case message
      when "victory" then puts "Congratulations! You win!\n"
      when "correct" then puts "Correct!\n"
      when "game over" then puts "Sorry! You lose.\n"
      when "incorrect" then puts "Nope, sorry. #{@chances} remaining.\n"
    end
  end

end

game = Hangman.new(get_dictionary)

