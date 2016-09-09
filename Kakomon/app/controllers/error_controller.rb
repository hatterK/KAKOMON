class ErrorController < ApplicationController
  def not_found
    raise ActionController::RoutingError, "No route matches #{request.path.inspect}"
  end

  def bad_request
    raise ActionController::ParameterMissing, ""
  end

  def internal_server_error
    raise Exception
  end
end
