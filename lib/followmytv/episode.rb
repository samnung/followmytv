
module Followmytv
  class Episode
    attr_accessor :id

    # @return [String]
    #
    attr_accessor :title

    # @return [String]
    #
    attr_accessor :number

    # @return [String]
    #
    attr_accessor :link

    # @return [String]
    #
    attr_accessor :air_date

    # @return [TrueClass, FalseClass]
    #
    attr_accessor :watched


    # @return [Float]
    #
    attr_accessor :rating

    # @return [Fixnum]
    #
    attr_accessor :votes_count

    # @param json [Hash]
    #
    def update_with_json(json)
      @id = json.delete('id')
      @title = json.delete('title')
      @number = json.delete('number')
      @link = json.delete('link')
      @air_date = json.delete('airdate')
    end

    # @param json [Hash]
    #
    # @return Followmytv::Episode
    #
    def self.from_json(json)
      inst = new
      inst.update_with_json(json)
      inst
    end
  end
end
