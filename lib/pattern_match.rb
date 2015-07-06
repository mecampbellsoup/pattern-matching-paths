$:.unshift File.dirname(__FILE__)

require 'pattern_match/pattern'
require 'pattern_match/path'
require 'pattern_match/runner'

module PatternMatch
end

class Array
  def with_optimized_wildcards
    # identify pattern with fewest wildcards
    fewest = self.reduce do |memo, pattern|
      memo.wildcard_count < pattern.wildcard_count ? memo : pattern
    end

    # check if multiple patterns have same number of wildcards
    multiple = self.select { |p| p.wildcard_count == fewest.wildcard_count }

    if multiple.size > 1
      multiple.reduce do |memo, pattern|
        memo.wildcards.first > pattern.wildcards.first ? memo : pattern
      end
    else
      fewest
    end
  end
end
