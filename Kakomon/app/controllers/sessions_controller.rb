class SessionsController < ApplicationController
  def create
    member = Member.authenticate(params[:name], params[:password])
    if member
      session[:member_id] = member.id
      redirect_to :root
    else
      flash.alert = 'ユーザー名とパスワードが一致しません。'
      render "members/index"
    end
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end
end
