require 'rails_helper'

RSpec.describe WorkController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'should render index page' do
      get :index

      expect(response.status).to be(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    it 'should create new work' do
      post :create, id: user.id, work: { description: 'bla bla' }, format: :js

      expect(response.status).to be(200)
      expect(Work.all.count).to be(1)
      expect(Work.first.description).to eq('bla bla')
    end

    it 'should not create empty work' do
      post :create, id: user.id, work: { description: '' }, format: :js

      expect(response.status).to be(200)
      expect(response).to render_template(:new)
      expect(Work.all.count).to be(0)
    end
  end

  describe 'DELETE #destroy' do
    let!(:work) { create(:work, user: user, complete: true) }
    let!(:work_2) { create(:work, user: user, complete: true) }
    let!(:work_3) { create(:work, user: user) }
    let(:user_2) { create(:user) }

    it 'should delete all finished works' do
      expect(Work.all.count).to be(3)
      delete :destroy, id: '42', format: :js

      expect(response.status).to be(200)
      expect(Work.all.count).to be(1)
      expect(Work.first).to eq(work_3)
    end

    it 'should delete works for only current user' do
      sign_in user_2
      expect(Work.all.count).to be(3)
      delete :destroy, id: '42', format: :js

      expect(response.status).to be(200)
      expect(Work.all.count).to be(3)
    end
  end

  describe 'GET #edit' do
    let!(:work) { create(:work, user: user, complete: true) }

    it 'should render edit temlate' do
      xhr :get, :edit, id: work.id, format: :js

      expect(response.status).to be(200)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let!(:work) { create(:work, user: user) }

    it 'should successfully update work' do
      xhr :put, :update, id: work.id, work: { description: 'new work' }, format: :js

      work.reload
      expect(response.status).to be(200)
      expect(work.description).to eq('new work')
    end

    it 'should not update work to empty' do
      xhr :put, :update, id: work.id, work: { description: '' }, format: :js

      work.reload
      expect(response.status).to be(200)
      expect(response).to render_template(:edit)
      expect(work.description).to_not eq('new work')
    end
  end

  describe 'POST #toggle_complete' do
    let!(:work) { create(:work, user: user) }

    it 'should toggle wrok to complete' do
      expect(work.complete).to be_falsey

      xhr :post, :toggle_complete, id: work.id, format: :js

      work.reload
      body = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(work.complete).to be_truthy
      expect(body["completed_works"]).to be_truthy
    end

    it 'should toggle wrok to uncomplete' do
      work = create(:work, user: user, complete: true)
      expect(work.complete).to be_truthy

      xhr :post, :toggle_complete, id: work.id, format: :js

      work.reload
      body = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(work.complete).to be_falsey
      expect(body["completed_works"]).to be_falsey
    end
  end
end
