module Movies
  class Result
    attr_reader :movie, :messages

    def initialize(movie, messages)
      @movie    = movie
      @messages = messages
    end

    def successful?
      messages.empty?
    end
  end
end
