
module Followmytv
  class Show
    # @return [String]
    #
    attr_reader :title

    # @return [String]
    #
    attr_reader :link

    # @return [Fixnum]
    #
    attr_reader :unwatched_count

    # @param json [Hash]
    #
    def update_with_json(json)
      @title = json.delete('title')
      @link = json.delete('link')
      @unwatched_count = json.delete('unwatched_count') { 0 }
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
