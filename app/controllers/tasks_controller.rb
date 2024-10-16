class TasksController < ApplicationController

  allow_unauthenticated_access only: [:index, :all]
  before_action :resume_session, only: [:index,:all]  
  
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_state]

  def index
    # This is accounting for using root account items if not logged in
    @tasks = Current.user ? Current.user.tasks : Current.root_user.tasks
    @tasks = @tasks#.active
  end
  
  def all
    # This is accounting for using root account items if not logged in
    @tasks = Current.user ? Current.user.tasks : Current.root_user.tasks
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


  def update_state
    @task.update(state: params[:state])
    render json: { status: 'success' }, status: :ok 
  end

  private

  def set_task
    @task = Current.user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :state, :due_date)
  end
end
