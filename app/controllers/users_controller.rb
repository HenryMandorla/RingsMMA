class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @recent_attendances = @user.attendances.includes(:gym_class)
                              .order(attended_at: :desc)
                              .limit(5)
  end

  def edit
    @min_hours = User::HOURS_FOR_BELT[@user.belt_level][:min]
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile was successfully updated.'
    else
      @min_hours = User::HOURS_FOR_BELT[@user.belt_level][:min]
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :belt_level, :mat_hours)
  end
end 