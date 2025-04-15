class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show]
  before_action :load_users_and_classes, only: [:new, :create] # Load data for dropdowns
  before_action :authenticate_user!

  # GET /attendances
  def index
    @attendances = current_user.attendances.includes(:gym_class).order(attended_at: :desc)
  end

  # GET /attendances/1
  def show
    # @attendance is set by before_action :set_attendance
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
    @users = User.all
    @gym_classes = GymClass.all

    if params[:gym_class_id]
      @gym_class = GymClass.find(params[:gym_class_id])
      @attendance.gym_class = @gym_class
      
      # Find the next occurrence of this class
      today = Date.today
      class_time = @gym_class.start_time
      day_of_week = class_time.strftime("%A")
      days_until = (Date::DAYNAMES.index(day_of_week) - today.wday) % 7
      next_class_date = today + days_until.days
      
      # Set the attended_at time to the next occurrence of this class
      @attendance.attended_at = Time.zone.local(
        next_class_date.year,
        next_class_date.month,
        next_class_date.day,
        class_time.hour,
        class_time.min
      )
    end
  end

  # POST /attendances
  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.user = current_user unless current_user.admin?

    if @attendance.save
      redirect_to attendances_path, notice: 'Attendance was successfully logged.'
    else
      @users = User.all
      @gym_classes = GymClass.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  # Load necessary data for the 'new' form dropdowns
  def load_users_and_classes
    @users = User.order(:name)
    @gym_classes = GymClass.order(:start_time)
  end

  # Only allow a list of trusted parameters through.
  def attendance_params
    params.require(:attendance).permit(:user_id, :gym_class_id, :attended_at)
  end
end


