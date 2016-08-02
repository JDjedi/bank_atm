class Account
	attr_accessor :account_number, :name, :balance, :pin

	def initialize(account_number, name, balance, pin)
		@account_number = account_number
		@name = name
		@balance = balance
		@pin = pin
	end
end 