require_relative '../test_helper'

describe PatternMatch::Pattern do
  let(:pattern) { "*,b,*" }
  subject       { PatternMatch::Pattern.new(pattern) }

  describe "#matches?" do
    let(:path) { PatternMatch::Path.new(path_string) }

    describe "when the path string matches the pattern without wildcards" do
      let(:pattern_string) { "foo, bar" }
      let(:pattern)        { PatternMatch::Pattern.new(pattern_string) }
      let(:path_string)    { "foo/bar" }

      it { pattern.matches?(path).must_equal true }
    end

    describe "when the path string matches the pattern with wildcards" do
      let(:path_string) { "/foo/b/bar/" }

      it { subject.matches?(path).must_equal true }
    end

    describe "when the path string does not match the pattern" do
      let(:path_string) { "/foo/bar/" }

      it { subject.matches?(path).must_equal false }
    end
  end

  it "sets the number of wildcards in the pattern" do
    subject.wildcard_count.must_equal(2)
  end

  it "sets an array of the wildcards' positions in the pattern" do
    subject.wildcards.must_equal([0, 2])
  end

  it "responds to #length" do
    subject.length.must_equal(3)
  end
end
