class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :toggle]
  skip_before_action :verify_authenticity_token#, if: :turbo_frame_request?

  allow_unauthenticated_access
  before_action :resume_session

  def index
    @todos = Current.root_user.todos.all
    @todo = Current.root_user.todos.new
  end  

  def show
  end

  def new
    @todo = Current.root_user.todos.new
  end

  def create
    @todo = Current.root_user.todos.new(todo_params)
    if @todo.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to todos_path }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@todo, partial: "todos/todo", locals: { todo: @todo }) }
        format.html { redirect_to todos_path, notice: 'Todo was successfully updated.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@todo, partial: "todos/todo", locals: { todo: @todo }) }
        format.html { render :edit }
      end
    end
  end

  def destroy
    @todo.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@todo) }
      format.html { redirect_to todos_path }
    end
  end

  def toggle
    @todo.update(completed: !@todo.completed)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@todo, partial: "todos/todo", locals: { todo: @todo }) }
      format.html { redirect_to todos_path }
    end
  end

  private
  # def turbo_frame_request?
  #   turbo_frame_request?
  # end
  def set_todo
    @todo = Current.root_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
