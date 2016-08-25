require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe 'ステータスコードチェック' do
    before do
      login Member.create(name: 'some_name', password: 'some_password', password_confirmation: 'some_password')
    end

    xit 'index' do
    end

    xit 'show' do
    end

    xit 'set_tag' do
    end

    xit 'untag' do
    end
  end
end
