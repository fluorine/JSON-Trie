# endoding:UTF-8

# This script allows the user to save many
# provided words and serialize them into
# JSON tries.

#
# A class to generate a JSON trie string.
#
class DictionaryTrie
  # Initialize a node and then
  # add it to the data structure.
  def initialize(str = nil)
    @word_end = false
    @chars = {}
    add(str.chomp) unless str == nil
  end

  # Add substring to dictionary.
  def add(word)
    if word == ""
      @word_end = true
    else
      if @chars[word[0]] == nil
        # Add new letter and recursively
        # add substring
        @chars[word[0]] =
           DictionaryTrie.new(word[1..-1])
      else
        # Add substring recursively
        @chars[word[0]].add(word[1..-1])
      end
    end
  end

  ##########################################
  # This method will be "transfered" soon. #
  ##########################################
  def get_words(chunk = "")
    # Add current sequence of characters,
    # if this node is marked as a word end.
    if @word_end
      words = [chunk] 
    else
      words = []
    end

    # Get more words, recursively
    @chars.each do |char, dic|
      words += dic.get_words(chunk + char)
    end

    words
  end

  def to_json
    pairs = []
    expr = ""

    # Marker for end of word
    if @word_end
      pairs += ["\"end\" : true"]
    else
      pairs += ["\"end\" : false"]
    end
    
    @chars.each do |char, values|
      pairs += ["\"#{char}\" : #{values.to_json}"]
    end

    " {" + pairs.join(", ") + "} "
  end

  def to_s
    @chars
  end
end

  #   #   #   #   #   #   #   #   #   #   #
  #              Entry point              #
  #   #   #   #   #   #   #   #   #   #   #

# Require .txt file as command line argument
if ARGV.length != 1 or ARGV[0].split(".")[1] != "txt"
  puts " Usage:\n   ruby generate.rb <file>.txt"
  exit
elsif not File.exist? ARGV[0]
  # Check if file exists
  puts " File '#{ARGV[0]}' does not exist."
  exit
end

# Open file and get all words
words = IO.read(ARGV[0]).scan(/\w+/)

# Add words to a new trie dictionary instance
dic = DictionaryTrie.new
words.each do |word|
  dic.add word
end

# Write JSON file as output
output_file = ARGV[0].split(".")[0] + ".json"
IO.write(output_file, dic.to_json)

puts "Output file '#{output_file}' has been generated."

# Show words in tree
#    p dic.get_words