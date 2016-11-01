require "movies/result"

RSpec.describe Movies::Result do
  let(:movie)          {double}
  let(:empty_messages) {[]}
  let(:messages)       {["a message"]}

  it "is successful if messages are empty" do
    result = described_class.new(movie, empty_messages)
    expect(result).to be_successful
  end

  it "is not successful if there are messages" do
    result = described_class.new(movie, messages)
    expect(result).not_to be_successful
  end
end
