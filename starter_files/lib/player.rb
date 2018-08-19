require_relative "hand"

module Playable
    def isBlackJack
    end
end
class Player
    #include Playable
    # include Hand

    def initialize(cash)
        @cash = cash
        ready
    end

    def startingCash(cash)
        @cash = cash
    end

    def wins(cash)
        @cash += cash
    end
    def card(card)
        @hand.addCard(card)
    end

    def handTotal
        @hand.showHandValue
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
        print " and a total of #{@hand.showHandValue} \n"
    end 
    
    def isBlackJack
        @hand.isBlackJack?
    end
    def bet(cash)
        @cash=@cash-cash
        cash
    end

    def cashLeft
        @cash
    end

    def ready
        @hand = Hand.new
    end

    # def surrender
    # end
end
