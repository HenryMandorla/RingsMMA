# db/seeds.rb

puts "Cleaning database..."
Attendance.destroy_all
GymClass.destroy_all
User.destroy_all

puts "Creating Users..."
user1 = User.create!(
  name: "Alice Smith", 
  email: "alice@example.com",
  password: "password123",
  password_confirmation: "password123"
)
user2 = User.create!(
  name: "Bob Johnson", 
  email: "bob@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "Creating Gym Classes..."

# Helper method to create class times
def create_weekly_class(name, day_of_week, start_time_str, end_time_str, max_capacity = 20)
  # Get next occurrence of the specified day
  day_num = Date::DAYNAMES.index(day_of_week)
  today_num = Date.today.wday
  days_until = (day_num - today_num) % 7
  next_date = Date.today + days_until.days
  
  # Create the full datetime strings
  start_datetime = "#{next_date.strftime('%Y-%m-%d')} #{start_time_str}"
  end_datetime = "#{next_date.strftime('%Y-%m-%d')} #{end_time_str}"
  
  GymClass.create!(
    name: name,
    start_time: Time.zone.parse(start_datetime),
    end_time: Time.zone.parse(end_datetime),
    max_capacity: max_capacity,
    description: "Regular #{name} class"
  )
end

puts "Creating Monday classes..."
create_weekly_class("Striking for MMA", "Monday", "17:30", "18:30")
create_weekly_class("MMA", "Monday", "18:30", "19:30")

puts "Creating Tuesday classes..."
create_weekly_class("Women's Kickboxing", "Tuesday", "17:15", "18:45")
create_weekly_class("No-Gi Jiu-Jitsu", "Tuesday", "18:00", "19:30")

puts "Creating Wednesday classes..."
create_weekly_class("Striking for MMA", "Wednesday", "17:30", "18:30")
create_weekly_class("MMA", "Wednesday", "18:30", "19:30")

puts "Creating Thursday classes..."
create_weekly_class("Girls Self-Defence Kickboxing", "Thursday", "16:00", "16:45")
create_weekly_class("Women's Kickboxing", "Thursday", "17:15", "18:45")
create_weekly_class("No-Gi Jiu-Jitsu", "Thursday", "18:00", "19:30")

puts "Creating Friday classes..."
create_weekly_class("Striking for MMA", "Friday", "17:30", "18:30")
create_weekly_class("MMA", "Friday", "18:30", "19:30")

puts "Creating sample attendances..."
first_class = GymClass.first
second_class = GymClass.second
third_class = GymClass.third

Attendance.create!(
  user: user1, 
  gym_class: first_class, 
  attended_at: first_class.start_time
)
Attendance.create!(
  user: user2, 
  gym_class: second_class, 
  attended_at: second_class.start_time
)
Attendance.create!(
  user: user1, 
  gym_class: third_class, 
  attended_at: third_class.start_time - 5.minutes
)

puts "Seed completed!"
puts "Created #{User.count} users"
puts "Created #{GymClass.count} gym classes"
puts "Created #{Attendance.count} attendance records"
