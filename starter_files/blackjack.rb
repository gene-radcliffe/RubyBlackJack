require_relative "lib/deck"
require_relative "lib/dealer"
require_relative "lib/player"
puts "TODO Implement the game of blackjack."

# Hint: for starters, read bin/blackjack.rb
class BlackjackGame
    def initialize
        @GAME_OVER=false
        @deck = Deck.new.shuffle
        @dealer = Dealer.new
        @player = Player.new(1000)    
        @clear_code = %x{clear}
        @esc_code = "\u001B"
        @key_pressed
        @hit = false
        @stand = false
        startGame
    end 
    
    def startGame
        welcomeMessage
        clearScreen
        gameLoop
    end


    def gameLoop
       
        while @GAME_OVER != true 
            puts "starting deck"
            @dealer.shuffleDeck #shuffle a new Deck
            
            #start to play until the deck is gone
            begin 
                #new game or round
                @pot = @player.bet(100)
                bet = @pot
                @dealer.ready
                @player.ready
                2.times { @player.card(@dealer.dealCard)}
                2.times {@dealer.dealerHand(@dealer.dealCard)}
            
                playHand = true
                #loop to play a hand
                begin 
                 
                    clearScreen
                    puts "You have #{@player.cashLeft} and bet #{bet}"
                    @dealer.showCard
                    @player.showHand 
                   
                
                    ans=hitOrStand 
                        if ans == "h" then
                            playersTurn
                        elsif ans == "s"  
                            dealersTurn #dealer takes his turn
                            playHand=false #exit the inner loop for playing the hand 
                        end
                end while(playHand == true)
                
                whoWon?
                puts "Play another hand?"
                ans=gets.chomp.downcase
                if ans == "n" then
                    @GAME_OVER=true
                    break
                end
            end while(@dealer.cardsLeft !=0)
            
            
        end
        puts "thanks for playing!"
    end
    def whoWon?
        puts "who is winning? Dealer: #{@dealer.handTotal}  Player: #{@player.handTotal}"
        if @player.handTotal  ==  @dealer.handTotal
             puts "-- It is a push!--"
        # elsif @player.handTotal <21 && @dealer.handTotal <21
        elsif @player.handTotal > @dealer.handTotal then
            puts "You Win"
        elsif @player.handTotal < @dealer.handTotal then
            puts "Dealer Wins!"
        
        # # elsif @player.handTotal > && @dealer.handTotal then
        # #     #you loose
        # #     puts "BUST"
        # # elsif @player.handTotal <= 21 && @dealer.handTotal > 21 then
        # #     "The Dealer bust. You Win"
        # # elsif @player.handTotal 
        end

    end
    def playersTurn
        @player.card(@dealer.dealCard) #dealer gives the player a card
        puts "total #{@player.handTotal}" #display the player's hand
        if @player.handTotal >21 then
            puts "Bust! you loose this hand [push enter]"
            readline
            playHand = false #exit the inner loop for playing the hand
         end
        #check player's hand if it is 21 (blackjack)
         if @player.handTotal == 21 then
            5.times{puts "Blackjack!"}
            puts "The dealer will nowtake his turn [push enter]"
            readline
            dealersTurn
            playHand =false #exit the inner loop for playing the hand 
         end
    end
    def dealersTurn
        dealer_hits =true
        #dealer hits until he hits 21 
        begin
            break if @dealer.handTotal >=21
            #if dealer is between 17 and 21 -- stay
            # if @dealer.handTotal >= 17 && @dealer.handTotal <= 21 then
            @dealer.showHand
            @dealer.dealerHand(@dealer.dealCard)
            sleep(1)
            if @player.handTotal >21 then
                puts "Bust! Dealer loose this hand [push enter]"
                readline
                playHand = false #exit the inner loop for playing the hand
             end
        end while(dealer_hits)
        dealer_hits=false
    end
   
    def welcomeMessage
        print "Hello and welcome to the game of blackjack! Let's begin. [press any key]"
        @key_pressed = gets
    end
    def looseMessage
        print "Hello and welcome to the game of blackjack! Let's begin. [press any key]"
        @key_pressed = gets
    end
    
    def clearScreen
        print @clear_code
    end

    def hitOrStand
        answer = ""
        begin 
          puts "Do you want to (h)it or (s)tand? #{answer =="s"}"
          answer = gets.chomp.downcase
          break if answer[0] == "s" || answer[0] == "h"
        end while (true) 
        answer[0]
    end

end