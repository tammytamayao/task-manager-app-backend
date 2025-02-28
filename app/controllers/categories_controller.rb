class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :update, :destroy ]

  # GET /categories
  def index
    categories = Category.includes(:tasks)
    render json: categories.to_json(include: :tasks)
  end

  # GET /categories/:id
  def show
    render json: @category.to_json(include: :tasks)
  end

  # POST /categories
  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/:id
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  def destroy
    @category.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Category not found" }, status: :not_found
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
