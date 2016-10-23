require "result"

RSpec.describe Result do
  let(:movie)          {double}
  let(:empty_messages) {[]}
  let(:messages)       {["a message"]}

  it "is successful if messages are empty" do
    result = Result.new(movie, empty_messages)
    expect(result).to be_successful
  end

  it "is not successful if there are messages" do
    result = Result.new(movie, messages)
    expect(result).not_to be_successful
  end
end
