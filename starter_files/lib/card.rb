require 'set'

class Card
    
    attr_accessor :rank
    attr_accessor :suite
    
    def initialize(rank, suite)
        @rank = rank
        @suite = suite
        @card = nil
        @rank_hash = nil
        init_hash
    end

    def init_hash
      @rank_hash={
        :A=> 1, 
        2=> 2,
        3=> 3,
        4=> 4,
        5=> 5,
        6=> 6,
        7=> 7,
        8=> 8,
        9=> 9,
        10=> 10,
        :J=> 11,
        :Q=>12,
        :K=> 13
        }
    end

    def ==(other_card)
      
        self.rank == other_card.rank 
        #  && self.suite == other_card.suite
        # return other.rank == self.rank && other.suit == self.suit 
    end

    def greater_than?(other_card)
        other_card_rank = get_rank_from_hash(other_card.rank)
        this_card_rank = get_rank_from_hash(@rank)
  
        if this_card_rank > other_card_rank then
          true
        else
          false
        end
    end
  
    
    def get_rank_from_hash(card_rank)
        #@rank_hash[card_rank.to_s.to_sym]
        @rank_hash[card_rank]
    end
  
    
    
end
