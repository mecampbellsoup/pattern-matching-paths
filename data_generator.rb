class DataGenerator
  # 40 words
  WORDS = %w(foo bar baz cat dog tree bear bat shoe jeff tim left right five four three two one any thing can be in this array do me solid strap tie game let all pow jam sick irk watch skin blue)
  PATTERN_WORDS = WORDS + %w(* * * * * * * * * *)

  def self.pattern_string
    string = ""
    rand(1..4).times { string += "#{PATTERN_WORDS.sample}," }
    string[0...-1]
  end

  def self.path_string
    string = ""
    rand(1..4).times { string += "#{WORDS.sample}/" }
    string[0...-1]
  end

  def self.output!(num_patterns, num_paths)
    file_name = "fixtures/#{num_patterns}_patterns_#{num_paths}_paths.txt"
    f = File.new(file_name, "w+")
    # Write the number of patterns first
    f.write "#{num_patterns}\n"
    # Then write each pattern on its own line
    num_patterns.times { f.write "#{pattern_string}\n" }
    # Next write the number of paths
    f.write "#{num_paths}\n"
    # Then write each path on its own line
    num_paths.times { f.write "#{path_string}\n" }
  end
end

DataGenerator.output!(
  ARGV[0].to_i, ARGV[1].to_i
)
