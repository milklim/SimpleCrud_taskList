require 'rails_helper'

describe TasksController, :type => :controller do

  before do
    @user = FactoryBot.create(:user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(@user)
  end

  describe "getting tasks using route: get 'tasks/index'" do
    it 'has a 200 status code' do
      get :index, format: :json
      expect(response).to have_http_status (:success)
    end

    describe 'getting tasks for current user' do
      it 'should return 0 tasks' do
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(0)
      end

      it 'should return 1 tasks' do
        create_task(1)
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end

      it 'should return 10 tasks' do
        create_task(10)
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(10)
      end
    end
  end

  # describe "POST 'tasks'/'new'" do
  #   it ' should return HTTP status 200' do
  #     post :new
  #     expect(response).to have_http_status (:success)
  #   end
  # end


  describe "creating new task using route: post 'tasks/new'" do
    it 'has a 200 status code' do
      post :create, params: { task: { name: 'tsk_name',
                                      description: 'tsk_description',
                                      user_id: @user.id }},
                              format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should not create task with empty name' do
      post :create, params: { task: { name: '',
                                      description: 'tsk_description',
                                      user_id: @user.id }},
                              format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end

    it ' should not create task with empty description' do
      post :create, params: { task: { name: 'sdsdsd', description: '', user_id: @user.id }}, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end

    describe 'should create tasks: ' do
      it '1 task' do
        post :create, params: { task: { name: 'sdsdsd', description: 'sadasdasdas', user_id: @user.id }}, format: :json
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end

      it '5 tasks' do
        (0..4).each do |i|
          post :create, params: { task: { name: 'sdsdsd', description: 'sadasdasdas', user_id: @user.id }}, format: :json
        end
        get :index, format: :json
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end
  end

  # describe "PATCH 'task'/'update'" do
  #   it ' should return HTTP status 200' do
  #     task = FactoryBot.create(:task, user_id: @user.id)
  #     patch :update, params: { id: task.id, task: { name: 'updated task', description: 'updated task' } }, format: :json
  #     expect(response).to have_http_status (:success)
  #   end
  #
  #   it ' should update task name' do
  #     task = FactoryBot.create(:task, user_id: @user.id)
  #     patch :update, params: { id: task.id, task: { name: 'updated task', description: 'updated task' } }, format: :json
  #     expect(JSON.parse(response.body)['name']).to eq('updated task')
  #     expect(JSON.parse(response.body)['description']).to eq('updated task')
  #   end
  #
  #   it ' should not update task name to empty' do
  #     task = FactoryBot.create(:task, user_id: @user.id)
  #     patch :update, params: { id: task.id, task: { name: '', description: 'sadasdasdas' } }, format: :json
  #     expect(response).to have_http_status (:unprocessable_entity)
  #   end
  #
  #   it ' should not update task description to empty' do
  #     task = FactoryBot.create(:task, user_id: @user.id)
  #     patch :update, params: { id: task.id, task: { name: 'sdsdsd', description: '' } }, format: :json
  #     expect(response).to have_http_status (:unprocessable_entity)
  #   end
  #
  #   it ' should update is_done' do
  #     task = FactoryBot.create(:task, user_id: @user.id)
  #     patch :update, params: { id: task.id, task: { is_done: true } }, format: :json
  #     expect(JSON.parse(response.body)['is_done']).to eq(true)
  #   end
  #
  #   it ' should update importance' do
  #     task = FactoryBot.create(:task, user_id: @user.id)
  #     patch :update, params: { id: task.id, task: { importance: 'low' } }, format: :json
  #     expect(JSON.parse(response.body)['importance']).to eq('low')
  #   end
  #
  # end

  # describe "DELETE 'task'/'destroy'" do
  #   it ' should destroy list' do
  #     task = FactoryBot.create(:task, user_id: @user.id)
  #     delete :destroy, params: { id: task.id }, format: :json
  #     expect(response).to have_http_status (:success)
  #   end
  #
  #   it ' should not destroy not existed list' do
  #     delete :destroy, params: { id: -1 }, format: :json
  #     expect(response).to have_http_status (:unprocessable_entity)
  #   end
  # end
  #
  # describe "set_lang" do
  #   it ' set ru locale' do
  #     @user.set_lang(:ru);
  #     expect(@user.lang).to eq ("ru")
  #   end
  #
  #   it ' set en locale' do
  #     @user.set_lang(:en);
  #     expect(@user.lang).to eq ("en")
  #   end
  # end
end

def create_task(n)
  for i in 1..n
    FactoryBot.create(:task, user_id: @user.id)
  end
end