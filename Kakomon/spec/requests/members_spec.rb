require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe 'ステータスコードチェック' do
    let(:admin_member)   { Member.create(name: 'some_admin_member', access_authority: 1, password: 'some_password')}
    let(:user_member) { Member.create(name: 'some_user_member', access_authority: 3, password: 'some_password') }

    it 'index' do
      get members_path
      expect(response).to have_http_status(:ok)
    end

    it 'new' do
      login admin_member
      get new_admin_member_path

      expect(response).to have_http_status(:ok)
    end

    it 'edit' do
      login admin_member
      get (edit_admin_member_path id: user_member.id)

      expect(response).to have_http_status(:ok)
    end

    it 'show' do
      login admin_member
      get (admin_member_path id: user_member.id)

      expect(response).to have_http_status(:ok)
    end

    it 'create' do
      login admin_member
      post admin_members_path, member: { name: 'some_new_memeber', password: 'new_password', password_confirmation: 'new_password', access_authority: 1 }

      expect(response).to have_http_status(:see_other)
    end

    it 'update' do
      login admin_member
      put (admin_member_path id: user_member.id), member: { name: 'some_changed_name' }

      expect(response).to have_http_status(:see_other)
    end

    it 'destroy' do
      login admin_member
      delete (admin_member_path id: user_member.id)

      expect(response).to have_http_status(:see_other)
    end
  end
end
