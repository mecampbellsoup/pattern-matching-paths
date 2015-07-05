require_relative '../test_helper'

describe PatternMatch::Runner do
  describe "when the input file path is valid" do
    let(:valid_path) { "example_input.txt" }
    let(:matcher)    { PatternMatch::Runner.new(valid_path) }

    describe "#match!" do
      it "returns the best-matching pattern for each path" do
        matcher.match!.must_equal([
          "*,x,y,z",
          "a,*,*",
          "NO MATCH",
          "NO MATCH",
          "foo,bar,baz"
        ])
      end
    end

    it "initializes an array of the patterns" do
      matcher.patterns.must_equal([
        "*,b,*",
        "a,*,*",
        "*,*,c",
        "foo,bar,baz",
        "w,x,*,*",
        "*,x,y,z"
      ])
    end

    it "initializes an array of the paths to be matched" do
      matcher.paths.must_equal([
        "/w/x/y/z/",
        "a/b/c",
        "foo/",
        "foo/bar/",
        "foo/bar/baz/"
      ])
    end
  end

  describe "when the input file path is not valid" do
    let(:invalid_path) { "foo" }

    it "outputs a helpful message" do
      proc { PatternMatch::Runner.new(invalid_path) }.must_output "No such file or directory @ rb_sysopen - foo"
    end
  end
end
