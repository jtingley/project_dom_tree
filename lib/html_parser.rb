
class HTMLParser
  attr_reader :attribute_regex, :tag_regex

  def initialize(args = {})
    @tag_regex        = args[:tag_regex] || /<(\w+)/
    @attribute_regex  = args[:attr_regex]|| /\w+='[\w\s]+'?/
  end

  def parse_tag(tag)
    type = tag.match(tag_regex)
    type = type.captures[0] if type
    attributes_and_values = capture_attributes(tag)
    tag_hash = attributes_to_hash(attributes_and_values)
    tag_hash.store("type", type)
    tag_hash
  end

  private
    def capture_attributes(tag)
      tag.scan(attribute_regex)
    end

    def attributes_to_hash(attribute_groups)
      attributes_values = {}
      attribute_groups.each do |group|
        key, values = group.split('=')
        values = values.gsub('\'', '').split(' ')
        attributes_values[key] = values
      end
      attributes_values
    end
end

