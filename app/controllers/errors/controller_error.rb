# frozen_string_literal: true

module Errors
  class ControllerError < StandardError
    attr_reader :status, :message

    def initialize(message, status = nil)
      super(message)
      @status = status
      @message = message
    end
  end
end
