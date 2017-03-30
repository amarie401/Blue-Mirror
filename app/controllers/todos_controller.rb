class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.where('user_id = ?', current_user)
    render json: @todos
  end

  def featured
    @todos = Todo.where('featured = true').map(&:todo)
    @todos << get_featured('db/data/todos.seed')
    render json: @todos.flatten.uniq
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    render json: @todo
  end

  # POST /todos
  # POST /todos.json
  def create
    params['user_id'] = current_user.id if current_user
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: { location: @todo }, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find_by_id(params[:id])
    @todo = {} if different_user?(@todo)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def todo_params
    params.permit(:todo, :user_id)
  end
end
