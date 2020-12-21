filename = $0

# file = File.open(filename, "r")

File.foreach(filename) { |line| puts line }

# file.close
