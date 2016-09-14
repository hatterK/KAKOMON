class Editor::Base < ApplicationController
  before_action :editor_login_required

  def editor_login_required
    raise Forbidden unless editor_member
  end
end
