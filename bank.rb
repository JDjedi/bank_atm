load "account_maker.rb"

class Bank

	attr_accessor :int_account_number, :int_account_pin, :error_counter

	def initialize
		@accounts = {}
		@int_account_number = int_account_number
		@int_account_pin = int_account_pin
		@error_counter = error_counter
	end

	def add_account(account_number, name, balance, pin)
		@accounts[account_number] = Account.new(account_number, name, balance, pin)
	end

	def account_number_login
		puts "Hi and welcome to Software Bank."
		puts "Please enter your 7 digit account number."
		account_number = gets.chomp
		int_account_number = account_number.to_i

		if @accounts.has_key?(int_account_number) && (/^\w{7}$/ === account_number)
			thank_you_msg
			pin_login(int_account_number)
		else
			error_msg
			account_number_login
		end
	end

	@error_counter = 0

	def pin_login(int_account_number)

		

		puts "Please enter your 4 digit pin."
		account_pin = gets.chomp
		int_account_pin = account_pin.to_i #May have to use this later

		#puts int_account_number, int_account_pin

		if @accounts[int_account_number].pin == int_account_pin && (/^\d{4}$/ === account_pin) 
			thank_you_msg
			main_menu(int_account_number)
		elsif @error_counter == 4
			puts "****************************"
			puts "Too many failed login attempts"
			puts "****************************"
			@error_counter = 0
			account_number_login()
		else
			error_msg
			@error_counter += 1
			pin_login(int_account_number) #may need to pass error_counter variable here
		end
	end

	def main_menu(int_account_number)
		puts "Hello, #{@accounts[int_account_number].name}"
		puts "Your balance is #{@accounts[int_account_number].balance}"
		puts "Would you like to make a deposit or withdrawl?"
		option = gets.chomp
		option.downcase!

		if option == "deposit"
			puts ""
			puts "****************************"
			puts ""
			deposit(int_account_number)
		elsif option == "withdrawl"
			puts ""
			puts "****************************"
			puts ""
			withdrawl(int_account_number)
		else
			error_msg
			main_menu(int_account_number)
		end

	end

	def deposit(int_account_number)
		puts "How much would you like to deposit?"
		deposit_amount = gets.chomp

		if deposit_amount.match(/\D+/)
			error_msg
			deposit(int_account_number)
		else
			int_deposit_amount = deposit_amount.to_i
			@accounts[int_account_number].balance = @accounts[int_account_number].balance + int_deposit_amount
			puts ""
			puts "****************************"
			puts "You deposited $#{deposit_amount}"
			puts "Your new balance is $#{@accounts[int_account_number].balance}"
			puts "****************************"
			puts ""
			thank_you_msg
			account_number_login
		end
	end

	def withdrawl(int_account_number)
		puts "How much would you like to withdrawl?"
		puts "You may only withdrawl in increments of 10."

		withdrawl_amount = gets.chomp

		if withdrawl_amount.match(/\D+/)
			error_msg
			withdrawl(int_account_number)
		else
			int_withdrawl_amount = withdrawl_amount.to_i
			if (int_withdrawl_amount % 10) != 0
				error_msg
				withdrawl(int_account_number)
			else
				@accounts[int_account_number].balance = @accounts[int_account_number].balance - int_withdrawl_amount
				puts ""
				puts "****************************"
				puts "Your money will now be despensed"
				puts "Your new balance is $#{@accounts[int_account_number].balance}"
				puts "****************************"
				puts ""
				thank_you_msg
				account_number_login
			end
		end
	end

	def error_msg
		puts ""
		puts "****************************"
		puts "Please enter a valid option"
		puts "****************************"
		puts ""
	end

	def thank_you_msg
		puts ""
		puts "****************************"
		puts "Thank you."
		puts "****************************"
		puts ""
	end

end

bank_login = Bank.new
bank_login.add_account(1234567, "Jonathan Diaz", 500000000.00, 1234)
bank_login.add_account(3344567, "Hugo Ramierez", 7234340.00, 3344)
bank_login.add_account(9830432, "Sergio Rodriguez", 12000000.00, 4781)
bank_login.add_account(2345223, "Monica Viramontez", 320000000.00, 3812)
#bank_login.account_test
bank_login.account_number_login()

