class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Current.user.tasks.active.order(state: :asc)
  end

  def all
    @tasks = Current.user.tasks.order(due_date: :asc)
    render :index
  end

  def show
  end

  def new
    @task = Current.user.tasks.new
  end

  def create
    @task = Current.user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Task created successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task destroyed successfully!'
  end

  def collapse
    @task.collapse
    redirect_to tasks_url, notice: 'Task collapsed successfully!'
  end

  def uncollapse
    @task.uncollapse
    redirect_to tasks_url, notice: 'Task uncollapsed successfully!'
  end

  private

  def set_task
    @task = Current.user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :state, :due_date)
  end
end
