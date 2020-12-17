def print_header
  puts "The students of Villains Academy"
  "-------------"
end

def print(students)
  students.each_with_index do |student, idx|
    puts "#{idx + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of input_students
  students = filter_output(students)
end

def filter_output(student_dir)
  ret_students = []
  # Filter option for start name string match
  puts "You can filter output based on name search character(s)"
  puts "Would you like to apply any filter criteria? Enter 'yes' or leave empty to skip"

  return if gets.chomp.empty?

  puts "Enter name search character(s) or hit enter to ignore"
  filter_string = gets.chomp.capitalize

  student_dir.entries.each do |student|
    # Check name string
    if !filter_string.empty?
      unless student[:name] =~ /^#{filter_string}/
        next
      end
    end
    ret_students << student
  end

  return ret_students
end


# Call methods to print student list
students = input_students
print_header
print(students)
print_footer(students)
