class TasksController < ApplicationController

  def index
    render json: Task.order("id desc")
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end

  def create
    new_task = params[:task]
    @task = Task.new
    @task.name = new_task[:name]
    if @task.save
      render json: @task
    else
      render nothing: true, status: :bad_request
    end
  end

  def update
    @task = Task.find(params[:id])
    new_task = params[:task]
    @task.name = new_task[:name]
    @task.done = new_task[:done]
    if @task.save
      render json: @task
    else
      render nothing: true, status: :bad_request
    end
  end
end
