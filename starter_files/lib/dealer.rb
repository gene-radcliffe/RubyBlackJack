require_relative "hand"
class Dealer
    

    def initialize
        @deck= Deck.new
        ready
    end
    def cardsLeft
        @deck.cards_left
    end
    def dealCard
        @deck.draw
    end

    def dealerHand(card)
        @hand.addCard(card)
    end

    def handTotal
        @hand.handValue
    end
    def isBlackJack
        @hand.isBlackJack?
    end

    def ready
        @hand = Hand.new
    end

    def shuffleDeck
        @deck.shuffle
    end
    def showCard
        cards=@hand.cards
        puts "Dealer has a #{cards[0]}"
    end
    def showHand
    #You have a 9 and a 8 in your hand. Your total is 15.
        cards =  @hand.cards
        print "Dealer has a hand of: #{cards[0]}"
        cards.each_index{|card|
            c = card+1 
            break if c>cards.length
            print " and #{cards[c] }"
        }
        print " and a total of #{@hand.handValue} \n"
    end 
    def isBust?
        if @hand.handValue>21 then
           return true
        end
        return false
    end
    def isBlackJack?
        @hand.isBlackJack?
    end
end 