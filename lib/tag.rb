
require_relative 'html_parser'

class Tag
  attr_reader :source, :type, :id, :classes, :name

  PARSER = HTMLParser.new

  def initialize(args = {})
    @source = args.fetch(:source)
    @tag    = Tag.build(source)
    assign
  end

  private
    attr_reader :tag
    
    def self.build(source)
      PARSER.parse_tag(source)
    end

    def assign
    # takes values in tag class and assigns them to
    # instance varialbles
      @type = tag["type"]
      @classes = tag["class"]
      @id = tag["id"][0] if tag["id"]
      @name = tag["name"]
    end
end

