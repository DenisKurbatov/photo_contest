module Error
  class ApplicationError < StandardError
    attr_reader :error, :code, :message

    def initialize(error = nil, code = nil, message = nil)
      @error = error
      @code = code
      @message = message
    end
  end
end
