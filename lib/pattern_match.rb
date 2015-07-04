class PatternMatch
  def initialize(input_file_path)
    @input_file_path = input_file_path
    @data            = validate_input_file
  end

  def patterns
    @patterns ||= patterns_from_input_file
  end

  def paths
    @paths ||= paths_from_input_file
  end

  def match!
    paths.map { |p| best_pattern_match_for(p) }
  end

  private

  attr_reader :input_file_path, :data

  def best_pattern_match_for(path)
    # check for size first
    # get all paths matching same size
    same_size = patterns.select { |p| p.size == path.size }
    # for paths matching size, determine if it's a match
    matches = same_size.map { |p| matches?(p, path) }
    # a match will either directly or wildcard match each notch
    # if multiple matches, pick one(s) with fewest wildcards
    matches = matches.with_fewest_wildcards
    # if multiple wildcard matches, pick one whose first wildcard appears farthest right
  end

  def matches?(pattern, path)
    result = (0 .. path.size - 1).map do |i|
      case pattern[i]
      when path[i]
        path[i]
      when "*"
        "*"
      end
    end

    result.compact.size == path.size
  end

  def paths_from_input_file
    number_of_paths = data[patterns.size + 1].to_i
    data[patterns.size + 2, number_of_paths].map do |path|
      path.gsub(/\A\/|\/\Z/, "").split("/")
    end
  end

  def patterns_from_input_file
    number_of_patterns = data[0].to_i
    data[1, number_of_patterns].map { |p| p.split(",") }
  end

  def validate_input_file
    begin
      File.read(input_file_path).split(/\n/)
    rescue Errno::ENOENT => e
      $stdout.write e.message
    end
  end
end
