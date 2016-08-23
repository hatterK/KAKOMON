require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe 'ステータスコードチェック' do
    let(:super_member)   { Member.create(name: 'some_super_member', access_authority: 1, password: 'some_password')}
    let(:general_member) { Member.create(name: 'some_general_member', access_authority: 2, password: 'some_password') }

    it 'index' do
      get members_path
      expect(response).to have_http_status(:ok)
    end

    it 'new' do
      login super_member
      get new_member_path

      expect(response).to have_http_status(:ok)
    end

    it 'edit' do
      login super_member
      get (edit_member_path id: general_member.id)

      expect(response).to have_http_status(:ok)
    end

    it 'show' do
      login super_member
      get (member_path id: general_member)

      expect(response).to have_http_status(:ok)
    end

    it 'create' do
      login super_member
      post members_path, member: { name: 'some_new_memeber', password: 'new_password', password_confirmation: 'new_password', access_authority: 1 }

      expect(response).to have_http_status(:see_other)
    end

    it 'update' do
      login super_member
      put (member_path id: general_member.id), member: { name: 'some_changed_name' }

      expect(response).to have_http_status(:see_other)
    end

    it 'destroy' do
      login super_member
      delete (member_path id: general_member.id)

      expect(response).to have_http_status(:see_other)
    end
  end
end
