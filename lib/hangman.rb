require_relative 'word.rb'
require_relative 'noose.rb'

def get_dictionary
  file = File.open("dictionary.txt")
  dictionary = file.read.split("\r\n")
  dictionary = dictionary.delete_if { |word| word.length > 12 || word.length < 5 }
end

class Hangman
  attr_accessor :word, :chances, :letters_guessed
  
  def initialize(dictionary)
    puts "Welcome to Hangman."
    dictionary = dictionary
    @chances = 6
    @noose = Noose.new
    @word = Word.new(dictionary)
    @letters_guessed = []
    check_save
    turn
  end

  def check_save
    if File.exist? "saves/save_file"
      answer = nil
      data = nil
      loop do
        puts "Would you like to load a save file? (y/n): "
        answer = gets.chomp
        puts ""

        break if answer == "y" || answer == "n"

        puts "Invalid answer."
      end

      if answer == "y"
        File.open("saves/save_file") do |i|
          data = Marshal.load(i)
        end

        self.word = data.word
        self.letters_guessed = data.letters_guessed
        self.chances = data.chances

        puts "Save file loaded."
      else
        false
      end
      @noose.display_noose(@chances)
      @word.display_blanks
    else
      false
    end
  end

  def save_game?
    print "Save game and quit?(y/n): "
    answer = gets.chomp
    if answer == "y"
      true
    elsif answer == "n"
      false
    else
      puts "Invalid answer."
      save_game?
    end
  end

  def save_game
    Dir.mkdir("saves") unless Dir.exists?("saves")
    File.open("saves/save_file", "w+") do |info|
      Marshal.dump(self, info)
    end

    exit
  end
  
  def turn
    puts "\n"
    puts "Type \"save\" at any time to save and quit."
    @letters_guessed.sort!
    puts @letters_guessed.nil? ? "Letters guessed: None" : "Letters guessed: #{@letters_guessed.join(" ")}"
    @guess = get_guess
    check_guess
    puts "\n\n"
  end

  def get_guess
    print "Guess a letter: "
    guess = gets.chomp.downcase
    if guess == "save"
      save_game
    else
      guess
    end
  end

  def check_guess
    if @letters_guessed.include?(@guess)
      puts "You already tried that one!"
      @noose.display_noose(@chances)
      @word.display_blanks
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
        @word.display_blanks
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
        @word.display_blanks
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
      when "game over" then puts "Sorry! You lose. The word was #{@word.word}\n"
      when "incorrect" then puts "Nope, sorry. #{@chances} remaining.\n"
    end
  end

end

game = Hangman.new(get_dictionary)