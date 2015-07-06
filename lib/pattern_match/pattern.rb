module PatternMatch
  class Pattern
    attr_reader :wildcard_count, :wildcards, :pattern, :pattern_string

    def initialize(pattern_string)
      @pattern_string = pattern_string
      @pattern = pattern_string.split(",").map(&:strip)

      @wildcards = pattern.map.with_index do |p, i|
        i if p == "*"
      end.compact

      @wildcard_count = wildcards.size
    end

    def matches?(path)
      path_array = path.path
      # [ 'a', 'b', 'c'] <=> [*, 'b', *]
      matches = pattern.select.with_index do |key, i|
        [ "*", path_array[i] ].include? key
      end

      matches.size == pattern.size
    end

    def length
      pattern.length
    end
  end
end
