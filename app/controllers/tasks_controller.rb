class TasksController < ApplicationController
    before_action :set_task, only: [:show, :update, :destroy]
  
    # GET /tasks
    def index
      if params[:category].present?
        @tasks = Task.where(category: params[:category])  # Filter by category if provided
      else
        @tasks = Task.all
      end
      render json: @tasks
    end
  
    # GET /tasks/:id
    def show
      render json: @task
    end
  
    # POST /tasks
    def create
      @task = Task.new(task_params)
      if @task.save
        render json: @task, status: :created
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /tasks/:id
    def update
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /tasks/:id
    def destroy
      @task.destroy
      head :no_content
    end
  
    private
  
    # Find task by ID before updating or deleting
    def set_task
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Task not found' }, status: :not_found
    end
  
    # Strong parameters to allow only permitted fields
    def task_params
      params.require(:task).permit(:name, :description, :completed, :due_date, :category)
    end
  end
  
