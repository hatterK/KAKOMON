class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class Forbidden < StandardError; end

  private

  def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end
  helper_method :current_member

  def editor_member
    member = current_member
    member if member && member.access_authority < 3
  end
  helper_method :editor_member

  def super_member
    member = current_member
    member if member && member.access_authority < 2
  end
  helper_method :super_member

  def login_required
    raise Forbidden unless current_member
  end

  def editor_login_required
    raise Forbidden unless editor_member
  end

  def super_login_required
    raise Forbidden unless super_member
  end
end
