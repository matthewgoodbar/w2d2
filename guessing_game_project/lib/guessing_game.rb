class GuessingGame

    attr_reader :num_attempts

    def initialize(min, max)
        @min, @max = min, max
        @secret_num = rand(min..max)
        @num_attempts = 0
        @game_over = false
    end

    def game_over?
        @game_over
    end

    def check_num(num)
        @num_attempts += 1
        if num > @secret_num
            puts "too big"
        elsif num < @secret_num
            puts "too small"
        else
            puts "you win"
            @game_over = true
        end
    end

    def ask_user
        puts "Enter a number: "
        user_input = gets.chomp.to_i
        check_num(user_input)
    end

end
