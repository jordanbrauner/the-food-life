class BoxesController < ApplicationController

  before_action :vars, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @user = current_user
  end

  def show
    @box = Box.find(params[:id])
  end

  def new
    @box = @user.boxes.new
  end

  def create
    @box = @user.boxes.new(box_params)
    if @box.save
      flash[:notice] = "#{@box.title} was created."
      redirect_to user_boxes_path(@user)
    else
      render :new
    end
  end

  def edit
    @box = Box.find(params[:id])
    # @recipes = Recipe.all
    # @recipe = Recipe.find(params[:id])
  end

  def update
    @box = Box.find(params[:id])
    if @box.update!(box_params)
      flash[:notice] = "#{@box.title} was updated."
      redirect_to @box
    else
      render :edit
    end
  end

  def destroy
    @box = Box.find(params[:id])
    if @box.user_id == @user.id
      if @box.destroy
        flash[:notice] = "Box deleted."
        redirect_to boxes_path
      else
        flash[:notice] = "There was an error. Box not deleted."
        redirect_to boxes_path
      end
    else
      flash[:notice] = "This is not your box."
      redirect_to boxes_path
    end
  end

  # BOX METHODS
  def add_to_box
    @recipe = Recipe.find(params[:recipe_id])
    @box = Box.find(params[:id])
    @box.recipes.push(@recipe)
    redirect_to box_path(@box)

    # NOTE Not working. Problem with box_id?
    # @recipe = Recipe.find(params[:recipe_id])
    # @box = Box.find(params[:id])
    # if @box.recipes.find(@recipe.id)
    #   redirect_to box_path(@box)
    # else
    #   @box.recipes.push(@recipe)
    #   redirect_to box_path(@box)
    # end

  end

  def remove_from_box
    @recipe = Recipe.find(params[:recipe_id])
    @box = Box.find(params[:id])
    @box.recipes.destroy(@recipe)
    redirect_to box_path(@box)
  end

  # SET COMMON VARIABLES
  def vars
    @boxes = Box.all
    @recipes = Recipe.all
    @user = current_user
  end

  private
  def box_params
    params.require(:box).permit(:title, :description, :user_id)
  end

end
