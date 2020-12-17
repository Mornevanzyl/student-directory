class Student
  attr_accessor :visible, :name, :cohort, :country_of_origin, :hobbies

  def initialize(name, cohort, country, hobbies=[])
    @name = name
    @cohort = cohort.empty? ? Time.now.strftime("%B").downcase.to_sym : cohort
    @country_of_origin = country
    @hobbies = hobbies
    @visible = true
  end

  def list_hobbies
    return "List of Hobbies: " + (@hobbies.empty? ? "None" : @hobbies.join(", "))
  end

end
