
require_relative 'tag'

class HTMLDoc
  attr_accessor :file_path

  OPEN_TAG = /\A(<.*?>)[\w\s]+/
  CLOSE_TAG = /\A<\//

  def initialize(args = {})
    @file_path = args.fetch(:path)
  end

  def formatted_html
    read_result = unformatted_html
    read_result.gsub(/\n\s+{0,}/, '')
  end

  def output
  end

  def parse(html = formatted_html, parent = nil)
    return if html.match(CLOSE_TAG)
    # search for match of <.*?>
    tag_match = html.match(OPEN_TAG)
    if tag_match
      # conver matchdata to string form
      tag_source, content = parse_opening_tag(tag_match)
      # create new tag from html string
      tag = Tag.new(tag_source)
      link_tags(parent, tag)
      # get remaining html
      remaining_html = tag_match.post_match
      # recursively call w/ remaining html
      parse(remaining_html, tag)
    end
  end

  def parse_opening_tag(tag_match)
    tag_source = tag_match.captures[0]
    content = tag_match.gsub!(tag_source, "")
    [tag_source, content]
  end

  def link_tags(parent, child)
    if parent
      tag.parent = parent
      parent.children << tag
    end
  end

  def unformatted_html
    File.read(file_path)
  end
end

def test
  file_path = 'html/tiny.html'

  html = HTMLDoc.new(path: file_path)

  p html.formatted_html

  #html.output
end

