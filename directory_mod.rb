require './class_directory'
require './class_student'

def input_students

  # Instantiate our directory class
  student_dir = Directory.new('student', 'villain academy')

  puts "Let's capture some student data: -"
  puts "To finish, just hit return twice"

  loop do
    name = input_field("Please enter the student's name")
    break if name.empty?
    cohort = input_field("Enter the student cohort", nil, true)
    country = input_field("Enter student country of origin")
    hobbies = input_field("Enter one or more hobbies, return twice to finish", true)
    student = Student.new(name, cohort, country, hobbies)
    student_dir.add_entry(student)
  end

  # Call method to see if user wants to apply any filter criteria
  filter_output(student_dir)

  puts "Enter 'yes' to sort your output by cohort, hit enter for standard output"
  gets.chomp.downcase == "yes" ? student_dir.print_by_cohort : student_dir.print

end

def input_field(input_message, multiple=false, is_symbol=false)
  final_input = multiple ? [] : ""
  puts input_message
  if multiple
    while true do
      input = gets.chomp.capitalize
      break if input.empty?
      final_input << input
    end
  else
    final_input = gets.chomp.capitalize
  end
  return is_symbol ? final_input.downcase.to_sym : final_input
end

def filter_output(student_dir)

  # Filter option for start name string match
  puts "You can filter output based on name characters, name length or student cohort"
  puts "Would you like to apply any filter criteria? Enter 'yes' or leave empty to skip"

  return if gets.chomp.empty?

  puts "Enter name search character(s) or hit enter to ignore"
  filter_string = gets.chomp.capitalize

  # Filter option for maximum name length
  puts "Enter maximum length of name or hit enter to ignore this option"
  filter_length = gets.chomp

  # Filter option for cohort
  puts "Enter a specific cohort to print or hit enter to ignore"
  filter_cohort = gets.chomp

  student_dir.entries.each do |student|
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

# Call methods to print student list
input_students
# print_header
# print(students)
# print_footer(students)
