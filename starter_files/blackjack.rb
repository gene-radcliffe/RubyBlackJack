require_relative "lib/deck"

puts "TODO Implement the game of blackjack."

# Hint: for starters, read bin/blackjack.rb
class BlackjackGame
    def initialize
        @GAME_OVER=true 
        @deck = Deck.new.shuffle
        @dealer = Dealer.new
        @player = Player.new    
        @clear_code = %x{clear}
        @esc_code = "\u001B"
        @key_pressed
        startGame
    end 
    
    def startGame
        welcomeMessage
        clearScreen
        gameLoop
    end

    def gameLoop
        while d != 0
          
        end
    end

    def welcomeMessage
        print "Hello and welcome to the game of blackjack! Let's begin. [press any key]"
        @key_pressed = gets
    end
    
    def clearScreen
        print @clear_code
    end
    def hit
    end
    def stand
    end
end