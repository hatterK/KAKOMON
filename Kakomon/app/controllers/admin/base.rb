class Admin::Base < ApplicationController
  before_action :super_login_required

  layout 'admin.html.erb'

  private
  def super_login_required
    raise Forbidden unless super_member
  end
end
