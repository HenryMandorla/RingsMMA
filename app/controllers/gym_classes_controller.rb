class GymClassesController < ApplicationController
  before_action :set_gym_class, only: [:show, :edit, :update, :destroy, :add_learning]

  def index
    @gym_classes = GymClass.all
  end

  def show
    @class_learning = ClassLearning.new
    @class_learnings = @gym_class.class_learnings.includes(:user).order(created_at: :desc)
  end

  def new
    @gym_class = GymClass.new
  end

  def edit
  end

  def create
    @gym_class = GymClass.new(gym_class_params)

    if @gym_class.save
      redirect_to @gym_class, notice: 'Class was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @gym_class.update(gym_class_params)
      redirect_to @gym_class, notice: 'Class was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gym_class.destroy
    redirect_to gym_classes_url, notice: 'Class was successfully destroyed.'
  end

  def add_learning
    @class_learning = @gym_class.class_learnings.build(class_learning_params)
    @class_learning.user = current_user

    if @class_learning.save
      redirect_to @gym_class, notice: 'Learning was successfully added.'
    else
      @class_learnings = @gym_class.class_learnings.includes(:user).order(created_at: :desc)
      render :show, status: :unprocessable_entity
    end
  end

  private
    def set_gym_class
      @gym_class = GymClass.find(params[:id])
    end

    def gym_class_params
      params.require(:gym_class).permit(:name, :description, :start_time, :end_time, :max_capacity)
    end

    def class_learning_params
      params.require(:class_learning).permit(:content)
    end
end 