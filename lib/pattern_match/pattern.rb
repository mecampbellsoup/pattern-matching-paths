module PatternMatch
  class Pattern
    attr_reader :wildcard_count, :wildcards, :pattern

    def length
      pattern.length
    end

    def initialize(pattern_string)
      @pattern = pattern_string.split(",") 

      @wildcards = pattern.map.with_index do |p, i|
        i if p == "*"
      end.compact

      @wildcard_count = wildcards.size
    end
  end
end
