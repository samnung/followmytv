
module Followmytv
  class Episode
    attr_reader :id

    # @return [String]
    #
    attr_reader :title

    # @return [String]
    #
    attr_reader :number

    # @return [String]
    #
    attr_reader :link

    # @return [String]
    #
    attr_reader :air_date

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
