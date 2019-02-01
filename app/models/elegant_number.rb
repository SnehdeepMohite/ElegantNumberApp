require 'date'

class ElegantNumber

  def combinations(mobile_num)
    start_time = Time.now()

    return [] if mobile_num.nil? || mobile_num.length != 10 || mobile_num.split('').select{|a|(a.to_i == 0 || a.to_i == 1)}.length > 0

    letters = {
      "2" => ["a", "b", "c"],
      "3" => ["d", "e", "f"],
      "4" => ["g", "h", "i"],
      "5" => ["j", "k", "l"],
      "6" => ["m", "n", "o"],
      "7" => ["p", "q", "r", "s"],
      "8" => ["t", "u", "v"],
      "9" => ["w", "x", "y", "z"]
    }

    dictionary = {}

    for i in (1..30)
      dictionary[i] = []
    end

    file_path = Rails.root.join("db","dictionary.txt")

    File.foreach( file_path ) do |word|
      dictionary[word.length] << word.chop.to_s.downcase
    end

    keys = mobile_num.chars.map{|digit|letters[digit]}

    results = {}

    total_number = keys.length - 1

    for i in (2..total_number - 2)
      first_array = keys[0..i]
      next if first_array.length < 3
      second_array = keys[i + 1..total_number]
      next if second_array.length < 3
      first_combination = first_array.shift.product(*first_array).map(&:join)
      next if first_combination.nil?
      second_combination = second_array.shift.product(*second_array).map(&:join)
      next if second_combination.nil?
      results[i] = [(first_combination & dictionary[i+2]), (second_combination & dictionary[total_number - i +1])]
    end

    final_words = []

    results.each do |key, combinataions|

      next if combinataions.first.nil? || combinataions.last.nil?

      combinataions.first.product(combinataions.last).each do |combo_words|
        final_words << combo_words
      end
    end

    final_words << (keys.shift.product(*keys).map(&:join) & dictionary[11]).join(", ")

    end_time = Time.now()

    puts "Time #{end_time.to_f - start_time.to_f}"

    final_words
  end
end