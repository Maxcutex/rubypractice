class Hangman

  def initialize
    @secret_word = get_random_word
    @word_array = @secret_word.downcase.split("")
    @current_display = ('_' * @word_array.length).split("") #  Array.new(@word.size, "_")
    @guesses_remaining = 6
    @valid_guesses = ('a'..'z').to_a
    @previous_guesses = []
    startoption
  end

  def startoption
    puts "Do you want to start a fresh game, enter 'start' or load a previously saved game, enter 'load'"
    startop = gets.chomp.downcase
    if startop == "start"
      playgame
    elsif startop == "load"
      display_saved_games
    else 
      puts "You have not entered a valid option"
      startoption
    end
  end

  def get_random_word
    dictionary = File.read("5desk.txt").split("\r\n")
    valid_words = dictionary.select { |word| word.size >= 5 && word.size <= 12}
    word = valid_words.sample
  end 

  def get_guesses
    puts "\nKindly enter your guess letter  or type 'save' to save the game and 'quit' to quit the game entirely"
    guessed_letter = gets.chomp.downcase
    puts
    if guessed_letter == "save"
      save_game
    elsif guessed_letter == "quit"
      quit_game
    elsif @word_array.include?(guessed_letter)
      @word_array.each_with_index do |letter, index|
        @current_display[index] = guessed_letter if letter == guessed_letter
      end
      puts "The word contains the letter '#{guessed_letter}'!"
    else
      @guesses_remaining -= 1
      puts "Sorry, the word does not contain that letter."
    end
    @previous_guesses << guessed_letter
    show_status
  end
  
  def save_game 
    puts "Kindly enter the name for saving the game"
    filename = gets.chomp
    Dir.mkdir "saved_games" unless Dir.exists? "saved_games"
    filepath = "saved_games/#{filename}"
    remaining = @guesses_remaining.to_s
    saved_game = File.new(filepath, 'w')
    saved_game.write(@secret_word +"\n")
    saved_game.write(@current_display.join("") +"\n")
    saved_game.write(remaining +"\n")
    saved_game.write(@previous_guesses.join("")) 
    saved_game.close
    puts "Game saved successfully!"
    continue_or_quit
  end

  def continue_or_quit
    puts "Kindly enter 'c' to continue or 'q' to quit!!!"
    confirm = gets.chomp
    if confirm == "c"
      puts "Game continues!!!"
      playgame
    elsif confirm == "q"
      quit_game
    else
      puts "You have not entered a valid option "
      continue_or_quit
    end
  end

  def quit_game
    puts "Are you sure you want to quit the game? Type 'Yes' or 'No'"
    confirm = gets.chomp.downcase
    if confirm == "yes"
      exit
    elsif confirm == "no"
      playgame
    else 
        puts "You have not entered a valid option"
        quit_game
    end
  end


  def display_saved_games
    Dir.mkdir("saved_games") unless Dir.exists? "saved_games"
    games = Dir.glob('saved_games/*')
    if games.count == 0
      puts "You have no saved games yet."
      puts "Let's start a new game."
      return playgame
    else
      games.each {|x| puts "Saved file: #{x.split("/")[1]}"}
    end
    
    puts "Type the name of the saved game you'd like to access."
    input = gets.chomp
    load_saved_game(input)
  end 
  
  
  def load_saved_game(file_name) 
    saved_game = File.readlines("saved_games/#{file_name}")
    @previous_guesses = []
    @secret_word = saved_game[0]
    @word_array = @secret_word.downcase.split("")
    @current_display = saved_game[1].split("")
    @guesses_remaining = saved_game[2].to_i
    pr = saved_game[3]
    if !pr.nil?
    temp = saved_game[3].split("")
    temp.each {
      |tval|
      @previous_guesses << tval
    }
    end 

    File.delete("saved_games/#{file_name}")
    playgame
  end

  def show_status 
    puts "Guesses remaining to use: #{@guesses_remaining}"
    puts "Guessed letters: #{@previous_guesses.join(", ")}"
    puts "Word Built: #{@current_display.join()}"
  end

  def playgame 
    puts "New game of Hangman started!"
    show_status
    get_guesses while !game_over?
  end

  def game_over?
    if @guesses_remaining == 0
      puts "Oops, the word was '#{@secret_word}', you lose!"
      return true
    elsif !@current_display.include?("_")
      puts "You Win!"
      return true
    else
      return false
    end
  end

end


    
      
