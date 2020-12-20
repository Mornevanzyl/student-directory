require './class_directory'
require './class_student'

# Instantiate our directory class
@student_dir = Directory.new('student', 'villain academy')

def interactive_menu
  # Try load students from file if filename included as argument
  try_load_students

  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students()
  when "2"
    print_students()
  when "3"
    save_students()
  when "4"
    load_students()
  when "9"
    exit
  else
    puts "You have entered an invalid selection. Please try again"
  end
end

def input_students()

  puts "Let's capture some student data: -"
  puts "To finish, just hit return twice"

  loop do
    name = input_field("Please enter the student's name")
    break if (name.empty? || name == "")
    cohort = input_field("Enter the student cohort", nil, true)
    country = input_field("Enter student country of origin")
    hobbies = input_field("Enter one or more hobbies, return twice to finish", true)
    student = Student.new(name, cohort, country, hobbies)
    @student_dir.add_entry(student)
  end

end

def print_students()
  # Call method to see if user wants to apply any filter criteria
  filter_output()

  if @student_dir.print_output_empty
    puts "Your list is empty. Nothing will be printed"
    return
  end

  puts "Enter 'yes' to sort your output by cohort, hit enter for standard output"
  STDIN.gets.chomp.downcase == "yes" ? @student_dir.print_by_cohort : @student_dir.print

end

def save_students
  # Open file to save student list
  file = File.open("students.csv", "w")

  # Iterate over student list and write to csv file
  @student_dir.entries.each do |student|
    student_data = [student.name, student.cohort, student.country_of_origin, student.hobbies]
    csv_line = student_data.join(',')
    file.puts(csv_line)
  end
end

def load_students(filename = "students.csv")
  load_count = 0
  file = File.open(filename, "r")
  file.readlines.each do |line|
    a_line = line.chomp.split(",")
    name, cohort, country = a_line
    hobbies = []
    a_line.each_with_index do |el, i|
      if i > 2
        hobbies << el
      end
    end
    # Add students to list
    @student_dir.add_entry(Student.new(name, cohort, country, hobbies))
    load_count += 1
  end
  file.close
  puts "#{load_count} students successfully loaded from students.csv"
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist. Please retry with a valid filename"
    exit
  end
end

def input_field(input_message, multiple=false, is_symbol=false)
  final_input = multiple ? [] : ""
  puts input_message
  if multiple
    while true do
      input = STDIN.gets.chomp.capitalize
      break if input.empty?
      final_input << input
    end
  else
    final_input = STDIN.gets.chomp.capitalize
    # final_input = STDIN.gets.gsub(/\s|\n$/, "")
  end
  return is_symbol ? final_input.downcase.to_sym : final_input
end

def filter_output()

  # Reset visible status for entire list
  @student_dir.set_all_visible

  # Filter option for start name string match
  puts "You can filter output based on name characters, name length or student cohort"
  puts "Would you like to apply any filter criteria? Enter 'yes' or leave empty to skip"

  return if STDIN.gets.chomp.empty?

  puts "Enter name search character(s) or hit enter to ignore"
  filter_string = STDIN.gets.chomp.capitalize

  # Filter option for maximum name length
  puts "Enter maximum length of name or hit enter to ignore this option"
  filter_length = STDIN.gets.chomp

  # Filter option for cohort
  puts "Enter a specific cohort to print or hit enter to ignore"
  filter_cohort = STDIN.gets.chomp

  @student_dir.entries.each do |student|
    student.visible = false
    # Check student cohort
    if !filter_cohort.empty?
      unless student.cohort == filter_cohort.to_sym
        next
      end
    end
    # Check name string
    if !filter_string.empty?
      unless student.name =~ /^#{filter_string}/
        next
      end
    end
    # Check name length
    if !filter_length.empty?
      unless student.name.length <= filter_length.to_i
        next
      end
    end
    student.visible = true
  end

end

interactive_menu
