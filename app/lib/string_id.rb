# frozen_string_literal: false

class StringId
  # Load blocklisted words from CSV into an iterable data structure
  BLOCKLIST = File.read(Rails.root.join("lib/assets/blocklist_words.csv")).split('\n')
  # require 'csv' #if you have a more complicated CSV setup
  # BLOCKLIST = CSV.parse(@blocklist, :headers => true, :encoding => 'ISO-8859-1')

  # :reek:Attribute
  attr_accessor :max_length

  def initialize(max_length: 6)
    @max_length = max_length
  end

  def generate
    id = ""
    loop do
      id = sample_token
      break if acceptable?(sample_token)
    end
    id
  end

  private

  def acceptable?(sample_token)
    bad_id = false
    BLOCKLIST.each do |word|
      bad_id = sample_token.include? word
      break if bad_id # choose a new id if this one has a blocklisted word
    end
    !bad_id
  end

  # AKA @radix. URL safe, lowercase characters
  def lexicon
    @lexicon ||= ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a + ["-", "_"]
  end

  def sample_token
    id = ""
    # concat random letters from the lexicon together
    (1..max_length).each do
      id.concat(lexicon.sample)
    end
    id
  end
end
