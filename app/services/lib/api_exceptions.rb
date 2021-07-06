require_relative 'http_status_codes'

module ApiExceptions
  include HttpStatusCodes

  attr_reader :response

  HttpError = Class.new(StandardError)

  def response_successful?
    response.status == HTTP_SUCCESS
  end
end
