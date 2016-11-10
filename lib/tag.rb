
require_relative 'html_parser'

class Tag
  attr_reader :source, :type, :tag

  PARSER = HTMLParser.new

  def initialize(args = {})
    @source = args.fetch(:source)
    @tag    = Tag.build(source)
  end

  private
    def self.build(source)
      PARSER.parse_tag(source)
    end
end

