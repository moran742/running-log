require "CSV"

def help_menu
	puts
	puts "   log -new              Enter a new run"
	puts "   log -display          Display log"
	puts "   log -exit             Exit LogItReallyFast"
	puts
	main_routine()
end

def log_new_run
print "Enter Date of Run: "
date = gets.chomp()
print "Enter Time of run (minutes): "
time = gets.chomp()
print "Enter Distance of (miles): "
distance = gets.chomp()
print "Enter Comments on run: "
comments = gets.chomp()

logEntry = [date,time.to_i, distance.to_f, comments]
CSV.open("test.csv", "a") do |csv|
	csv <<(logEntry)
	end
puts
puts "Log entry recorded successfully."
puts
end

def display_log
	puts
	puts "Date           Time   Miles   Comments"
	puts "--------------------------------------"
	a = []
	log_array = CSV.read("test.csv")
	log_array.each do |row|
		s = ''
		row.each do |item|
			s = s + item 
			if row[2] == item && item.size > 3
				s = s + "    "
			else
				s = s + "     "
			end
		end
		puts s
	end
end

def welcome_screen
	print "\e[H\e[2J"
	puts "WelcomeLogItReallyFast v0.1"
	puts "---------------------------"
	puts "Type log -help to see usage instructions"
end

def main_routine
	print ">> "
	intitialInput = gets.chomp()
	if intitialInput.downcase == "log -help"
		help_menu()
	elsif intitialInput.downcase == "log -new"
		log_new_run()
	elsif intitialInput.downcase == "log -display"
		display_log()
	elsif intitialInput.downcase == "log -exit"
		exit!
	else
		puts "Not a valid entry.  To review options: log -help"
		return @failedRoutine = true
	end
end

welcome_screen()
main_routine()
while @failedRoutine
	main_routine()
end
