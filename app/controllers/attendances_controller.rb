class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @attendances = current_user.attendances
  end

  def show
  end

  def new
    @attendance = Attendance.new
    @gym_classes = GymClass.all
  end

  def create
    @attendance = current_user.attendances.build(attendance_params)

    if @attendance.save
      redirect_to @attendance, notice: 'Attendance was successfully created.'
    else
      @gym_classes = GymClass.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gym_classes = GymClass.all
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to @attendance, notice: 'Attendance was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @attendance.destroy
    redirect_to attendances_url, notice: 'Attendance was successfully destroyed.'
  end

  private

  def set_attendance
    @attendance = current_user.attendances.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:gym_class_id, :attended_at)
  end
end