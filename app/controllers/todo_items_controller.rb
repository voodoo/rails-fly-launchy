class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy, :collapse, :uncollapse]

  def index
    @todo_items = Current.user.todo_items#.active.order(due_date: :asc)
  end

  def show
  end

  def new
    @todo_item = Current.user.todo_items.new
  end

  def create
    @todo_item = Current.user.todo_items.new(todo_item_params)

    if @todo_item.save
      redirect_to todo_items_path , notice: 'Quantum task created successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo_item.update(todo_item_params)
      redirect_to todo_items_path, notice: 'Quantum task updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy
    redirect_to todo_items_url, notice: 'Quantum task destroyed successfully!'
  end

  def collapse
    @todo_item.collapse
    redirect_to todo_items_url, notice: 'Quantum task collapsed successfully!'
  end

  def uncollapse
    @todo_item.uncollapse
    redirect_to todo_items_url, notice: 'Quantum task uncollapsed successfully!'
  end

  private

  def set_todo_item
    @todo_item = Current.user.todo_items.find(params[:id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:title, :description, :state, :due_date)
  end
end