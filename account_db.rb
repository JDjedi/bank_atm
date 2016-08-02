require "rubygems"
require "sqlite3"
$db = SQLite3::Database.new("dbfile")
$db.results_as_hash = true

def diconnect_and_quit
	$db.close
	puts "Bye!"
	exit
end

def create_table
	puts "Creating accounts table..."
	$db.execute %q{
		CREATE TABLE accounts (
			account_number integer primary key,
			name varchar(50),
			balance decimal(13, 2),
			pin integer)
	}
	puts "Done."
	puts "*********************************"
end

def add_account
	puts "Enter the new account number:"
	account_number = gets.chomp
	puts "Enter the account holders name:"
	name = gets.chomp
	puts "Enter starting balance:"
	balance = gets.chomp
	puts "Enter account pin:"
	pin = gets.chomp
	$db.execute("INSERT INTO accounts (account_number, name, balance, pin) VALUES (?, ?, ?, ?)",
		account_number, name, balance, pin)
	puts "**********************************"
	puts "New account created successfully."
end

def find_person
	puts "Enter the account number of a customer to find:"
	account_number = gets.chomp

	account_holder = $db.execute("SELECT * FROM accounts WHERE account_number = ?", account_number.to_i).first

	unless account_number
		puts "No result found"
		return
	end

	puts %Q{Account Number: #{account_holder['account_number']}
		Name: #{account_holder['name']}
		Balance: #{account_holder['balance']}
	}
end

create_table
add_account
find_person









