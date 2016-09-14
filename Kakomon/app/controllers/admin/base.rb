class Admin::Base < ApplicationController
  before_action :super_login_required

  private
  def super_login_required
    raise Forbidden unless super_member
  end
end
