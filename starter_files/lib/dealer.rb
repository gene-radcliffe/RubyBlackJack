
class Dealer
    

    def initialize
        @deck= Deck.new
        @hand = Hand.new
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
        @hand.showHandValue
    end
    def isBlackJack
        @hand.isBlackJack?
    end
    
    def showHand
    #You have a 9 and a 8 in your hand. Your total is 15.
        cards =  @hand.cards
        print "You have a hand of: #{cards[0]}"
        cards.each_index{|card|
            c = card+1 
            break if c>cards.length
            print " and #{cards[c] }"
        }
        print " and a total of #{@hand.showHandValue}"
    end 
end 