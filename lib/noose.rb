class Noose

  def initialize

  end

  def display_noose(guesses)
    case guesses
    when 6 then puts blank_noose
    when 5 then puts add_head
    when 4 then puts add_body
    when 3 then puts add_left_arm
    when 2 then puts add_right_arm
    when 1 then puts add_right_leg
    when 0 then puts add_left_leg
    end
  end

  def blank_noose
    puts "____"
    puts "|   |"
    puts "|"
    puts "|"
    puts "|________"
  end

  def add_head
    puts "____"
    puts "|   |"
    puts "|   O"
    puts "|"
    puts "|________"
  end

  def add_body
    puts "____"
    puts "|   |"
    puts "|   O"
    puts "|   |"
    puts "|________"
  end

  def add_left_arm
    puts "____"
    puts "|   |"
    puts "|   O"
    puts "|   |\\"
    puts "|________"
  end

  def add_right_arm
    puts "____"
    puts "|   |"
    puts "|   O"
    puts "|  /|\\"
    puts "|________"
  end

  def add_right_leg
    puts "____"
    puts "|   |"
    puts "|   O"
    puts "|  /|\\"
    puts "|  /"
    puts "|________"
  end

  def add_left_leg
    puts "____"
    puts "|   |"
    puts "|   O"
    puts "|  /|\\"
    puts "|  / \\"
    puts "|________"
  end

end