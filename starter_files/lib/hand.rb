require_relative "card"

class Hand

    attr_accessor :value
    def initialize
        @cards=[]
        @value=0
        @aces=0

        @card_value_hash={
        :A=> 11, 
        2=> 2,
        3=> 3,
        4=> 4,
        5=> 5,
        6=> 6,
        7=> 7,
        8=> 8,
        9=> 9,
        10=> 10,
        :J=> 10,
        :Q=>10,
        :K=> 10
        }
    end


    def addCard(card) 
        accumulate_cards(card)
    end

    def accumulate_cards(card)
        #if ace check if already in hand, if so, just add 1 to the value
        if card.rank == :A then
          if aceInHand?(card) then
              return @value += 1 
          end
        end
        @value += @card_value_hash[card.rank] 
        @cards.push(card)           
    end
    def cards
      @cards
    end
    def aceInHand?(card)
        @cards.include?(card)
    end
    
end
