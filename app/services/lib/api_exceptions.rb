require_relative 'http_status_codes'

module ApiExceptions
  include HttpStatusCodes

  attr_reader :response

  MovieAPIError = Class.new(StandardError)
  BadRequestError = Class.new(MovieAPIError)
  UnauthorizedError = Class.new(MovieAPIError)
  ForbiddenError = Class.new(MovieAPIError)
  ApiRequestsQuotaReachedError = Class.new(MovieAPIError)
  NotFoundError = Class.new(MovieAPIError)
  UnprocessableEntityError = Class.new(MovieAPIError)
  InvalidParamsError = Class.new(MovieAPIError)
  ServiceOfflineError = Class.new(MovieAPIError)
  ApiError = Class.new(MovieAPIError)

  def response_successful?
    response.status == HTTP_SUCCESS
  end

  # handles the specific http status and raises the error for the user
  def http_error
    case response.status
    when HTTP_BAD_REQUEST_CODE
      BadRequestError
    when HTTP_UNAUTHORIZED_CODE
      UnauthorizedError
    when HTTP_FORBIDDEN_CODE
      ForbiddenError
    when HTTP_NOT_FOUND_CODE
      NotFoundError
    when HTTP_UNPROCESSABLE_ENTITY_CODE
      UnprocessableEntityError
    when HTTP_INVALID_PARAMS
      InvalidParamsError
    when HTTP_SERVICE_OFFLINE
      ServiceOfflineError
    else
      ApiError
    end
  end
end