module PatternMatch
  class Runner
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
      same_size = patterns.select { |p| p.length == path.size }
      matches = same_size.select { |p| p.matches?(path) }

      if matches.size == 1
        matches.first.pattern_string
      elsif matches.size > 1
        matches.with_optimized_wildcards.pattern_string
      else
        "NO MATCH"
      end
    end

    def paths_from_input_file
      number_of_paths = data[patterns.size + 1].to_i
      data[patterns.size + 2, number_of_paths].map do |path|
        Path.new(path)
      end
    end

    def patterns_from_input_file
      number_of_patterns = data[0].to_i
      data[1, number_of_patterns].map { |p| Pattern.new(p) }
    end

    def validate_input_file
      begin
        File.read(input_file_path).split(/\n/)
      rescue Errno::ENOENT => e
        $stdout.write e.message
      end
    end
  end
end
