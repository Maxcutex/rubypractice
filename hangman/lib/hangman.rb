puts "Hangman initialized."

lines = File.readlines "5desk.txt"
arr = Array.new
lines.each do |line|
  name = line.gsub(/\r/,"")
  name = name.gsub(/\n/,"")
  arr.push(name)
end

selected_array = arr.select {|a| a.length >= 5 && a.length <=12}

picked_text = selected_array.sample
allowed_attempt = 0
case picked_text.length
when 5
  allowed_attempt = 2
when 6
  allowed_attempt = 3
when 7
  allowed_attempt = 4
when 8,9,10
  allowed_attempt = 5
when 11,12
  allowed_attempt = 6
end

class Hangman

    def initialize
      @secret_word = get_random_word
      @current_display = '_' * @secret_word.length
      @incorrect_remaining = 6
      @valid_guesses = ('a'..'z').to_a
      @previous_guesses = []


    def get_random_word
      dictionary = File.read("dictionary.txt").split("\r\n")
      valid_words = dictionary.select { |word| word.size >= 5 && word.size <= 12}
      word = valid_words.sample.downcase.split("")

    def get_guesses
      
