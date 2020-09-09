class Word
  attr_accessor :word
  def initialize(dictionary)
    random_word(dictionary)
    @blanks = Array.new(@word.length)
  end

  def random_word(dictionary)
    @word = dictionary.sample(1).join("").downcase
  end

  def display_blanks
    print "Word: "
    @blanks.each { |letter| print letter.nil? ? " _ " : " #{letter} " }
    puts "\n\n"
  end

  def letter_in_word?(guess)
    if @word.to_s.downcase.include?(guess)
      update_blanks(guess)
      true
    else
      false
    end
  end

  def update_blanks(guess)
    letters = []
    @word.split("").each_with_index { |letter, i| letter == guess ? letters[i] = letter : next }
    letters.each_with_index { |letter, i| @blanks[i] = letter unless !@blanks[i].nil? }
  end

  def word_complete?
    true if @blanks.none? { |i| i.nil? }
  end
  
end