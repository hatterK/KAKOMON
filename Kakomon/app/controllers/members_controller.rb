class MembersController < ApplicationController
  def index
    @members = Member.order(:id)
  end
end
