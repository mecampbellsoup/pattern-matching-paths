require_relative '../test_helper'

describe PatternMatch::Pattern do
  let(:pattern) { "*,b,*" }
  subject       { PatternMatch::Pattern.new(pattern) }

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
