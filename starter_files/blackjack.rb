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
        @players_bet=0
        @pot=0
        @playHand
        
        startGame
    end 
    
    def startGame
        welcomeMessage
        clearScreen
        gameLoop
    end


    def gameLoop
       
        while @GAME_OVER != true 
            puts "Shuffling the deck"
            @dealer.shuffleDeck #shuffle a new Deck
            #start to play until the deck is gone
            begin 
                #new game or round
                puts "cards left: #{@dealer.cardsLeft}"
                @players_bet = @player.bet(100)
                @pot = @pot +  @players_bet + 100
                @dealer.ready
                @player.ready
                2.times { @player.card(@dealer.dealCard)}
                2.times {@dealer.dealerHand(@dealer.dealCard)}
            
                @playHand = true
                #loop to play a hand
                begin 
                 
                    clearScreen
                    puts "You have #{@player.cashLeft} and bet #{@players_bet}"
                    @dealer.showCard
                    @player.showHand 
                   
                
                    ans=hitOrStand 
                    if ans == "h" then
                        playersTurn
                    elsif ans == "s"  
                        dealersTurn #dealer takes his turn
                        @playHand=false #exit the inner loop for playing the hand 
                    end
                end while(@playHand == true)
                
                whoWon?
                puts "Play another hand? push (n) to exit or push any key to continue. cl: #{@dealer.cardsLeft}"
                ans=gets.chomp.downcase
                if ans == "n" then
                    @GAME_OVER=true
                    break #break the inner loop
                end
                if @dealer.cardsLeft <=8 then
                    puts "Well, we are about to run out of cards. Time to shuffle."
                    puts "Do you want to (s)huffle a new deck or e(x)it the game? "
                    ans = gets.chomp.downcase
                    if ans == "s" then
                       
                        break
                    elsif ans =="x"
                        @GAME_OVER = true
                        break
                    end
                end
            end while(@dealer.cardsLeft !=0)
            
            
        end
        puts "thanks for playing!"
    end
    def whoWon?
       
        #puts "who is winning? Dealer: #{@dealer.handTotal}  Player: #{@player.handTotal}"
        
        if @player.handTotal == @dealer.handTotal then
            puts "It is a push!"
            @player.wins(100)#give back 100
        end

        if @dealer.isBust? && !@player.isBust? then
            puts "You win #{@pot}"
            @player.wins(@pot)
        end

        if @player.isBust? && !@dealer.isBust? then
            puts "You loose #{@bet}"
        end

        if !@player.isBust? && !@dealer.isBust? then
            if @player.handTotal > @dealer.handTotal then
                puts "You Win! #{@pot}"
                @player.wins(@pot)
            elsif @player.handTotal < @dealer.handTotal 
                puts "The Dealer Wins! you loose $#{@players_bet}"
            end
        end
        @pot = 0#reset pot
    end
    def playersTurn
        @player.card(@dealer.dealCard) #dealer gives the player a card
        # puts "total #{@player.handTotal}" #display the player's hand

        if @player.isBust? then
            @player.showHand
            puts "Bust! you loose $#{@players_bet} on this hand. [push enter]"
            readline
            @playHand = false #exit the inner loop for playing the hand
         end

        #check player's hand if it is 21 (blackjack)
         if @player.isBlackJack? then
            5.times{puts "Blackjack!"}
            puts "The dealer will nowtake his turn [push enter]"
            readline
            dealersTurn
            @playHand =false #exit the inner loop for playing the hand 
         end
    end
    def dealersTurn
        dealer_hits =true
    
        #dealer hits until he hits 21 
        begin
            @dealer.showHand
           
            if !@dealer.isBlackJack? || !@dealer.isBust? then 
                puts "The dealer hits"    
                @dealer.dealerHand(@dealer.dealCard) 
            end
            if @dealer.handTotal >=17 && @dealer.handTotal <=21 then
                puts "the Dealer stands"
                @dealer.showHand
                break
            end 
            if @dealer.isBlackJack? then 
                @dealer.isBlackJack? 
                dealer_hits = false;
                @dealer.showHand
                puts "Blackjack! Dealer has Blackjack [push enter]"
                readline   
                break                          
            elsif @dealer.isBust? || @dealer.handTotal>21 then    
                dealer_hits=false

                puts "The Dealer Bust!" 
                @dealer.showHand
                puts "the dealer looses this hand [push enter]"
                readline
                break
            end
           
             sleep(1)
             
        end while(!@dealer.isBust?) 
        
    end
   
    def welcomeMessage
        print "Hello and welcome to the game of blackjack! Let's begin. [press enter]"
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

# old code
# if @player.handTotal  ==  @dealer.handTotal
#     puts "-- It is a push!--"
# # elsif @player.handTotal <21 && @dealer.handTotal <21
# elsif @player.handTotal > @dealer.handTotal then
#    puts "You Win"
# elsif @player.handTotal < @dealer.handTotal then
#    puts "Dealer Wins!"

# # # elsif @player.handTotal > && @dealer.handTotal then
# # #     #you loose
# # #     puts "BUST"
# # # elsif @player.handTotal <= 21 && @dealer.handTotal > 21 then
# # #     "The Dealer bust. You Win"
# # # elsif @player.handTotal 
# end
