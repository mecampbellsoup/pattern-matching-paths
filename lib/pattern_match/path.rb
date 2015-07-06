module PatternMatch
  class Path
    attr_reader :path, :path_string

    def length
      path.length
    end
    alias_method :size, :length

    def initialize(path_string)
      @path_string = path_string
      @path = path_string.gsub(/\A\/|\/\Z/, "").split("/")
    end
  end
end
