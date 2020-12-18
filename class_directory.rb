class Directory
  attr_accessor :entries

  def initialize(type, owner)
    @type = type.capitalize
    @owner = owner.capitalize
    @entries = []
  end

  def add_entry(entry)
    @entries.push(entry)
  end

  def print
    print_count = 0

    head_string = "The #{@type} Directory for #{@owner}"
    puts head_string
    puts "".center(head_string.length, "-")

    @entries.each do |entry|
      if entry.visible
        puts "#{entry.name}, from #{entry.country_of_origin} is part of the #{entry.cohort} cohort. Hobbies include #{entry.hobbies.join(', ')}"
        print_count += 1
      end
    end
    if print_count == @entries.count
      puts "Overall, we have #{@entries.count} great #{@type.downcase}" + (@entries.count > 1 ? "s" : "")
    else
      puts "#{print_count} #{@type.downcase}" + (print_count > 1 ? "s" : "") + " matched your filter criteria"
    end
  end

  def print_output_empty
    print_count = 0
    @entries.each { |entry| return false if entry.visible }
    return true
  end

  def print_by_cohort
    print_count = 0

    @entries.map! { |entry| [entry.cohort.to_s.capitalize, entry] }
    @entries.sort! { |a,b| b[0] <=> a[0] }


    head_string = "The #{@type} Directory for #{@owner}"
    puts head_string
    puts "".center(head_string.length, "-")

    @entries.each do |entry|
      if entry[1].visible
        puts "#{entry[1].name}, from #{entry[1].country_of_origin} is part of the #{entry[1].cohort} cohort. Hobbies include #{entry[1].hobbies.join(', ')}"
        print_count += 1
      end
    end
    if print_count == @entries.count
      puts "Overall, we have #{@entries.count} great #{@type.downcase}" + (@entries.count > 1 ? "s" : "")
    else
      puts "#{print_count} #{@type.downcase}" + (print_count > 1 ? "s" : "") + " matched your filter criteria"
    end
  end

end
