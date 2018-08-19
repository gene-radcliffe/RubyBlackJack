require_relative "card"

class Deck
    
    attr_accessor :shuffled_deck
  
    def init_hash
      @DECK_HASH = {
      clubs: [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K],
      diamonds: [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K],
      hearts: [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K],
      spades: [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]
      }
    
    end
    
    def init_deck
        create_deck
        @cards_left = @card_array.length
      
    end
    
    def initialize
        @card_array=[]
        init_hash
        init_deck
      
    end

    def draw
        #this can be replaced with @card_array#shift
      if @card_array.length >= 1 then
        @current_card = get_card
        delete_card_from_deck(@current_card)
      else
        @current_card = nil
      end
        @current_card
    end

   
    def shuffle
        create_deck
        @card_array.shuffle!
         
        # deck_clone = self.clone
        # deck_clone.shuffle_array
       
        # deck_clone 
    end

    def delete_card_from_deck(card)
      
        index = find_card(card)
        @card_array.delete_at(index)
      
    end

    def get_card
        if @card_array.length != 0 then
            @card_array[0]
        else    
            return nil
        end
    end

    def find_card(card)
      index_of_card = @card_array.find_index(card)
      index_of_card
    end

    def cards_left
        @cards_left = @card_array.length
    end
    def create_deck
    @card_array=[]
      @DECK_HASH.each do |k,v|
        v.each do |val|
          @card_array.push(Card.new(val,k))
        end
      end
    end

    def shuffle_array
      @card_array.shuffle!
    end
    
end 
