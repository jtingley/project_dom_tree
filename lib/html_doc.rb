
require_relative 'tag'

class HTMLDoc
  attr_accessor :file_path

  OPEN_TAG = /<.*?>/
  CLOSE_TAG = /<\//

  def initialize(args = {})
    @file_path = args.fetch(:path)
  end

  def formatted_html
    read_result = unformatted_html
    read_result.gsub(/\n\s+{0,}/, '')
  end

  def output
  end

  def parse(html, parent = nil)
    return if html.match(CLOSE_TAG)
    # search for match of <.*?>
    tag_match = html.match(OPEN_TAG)
    if tag_match
      # conver matchdata to string form
      tag_source = tag_match.to_s
      # create new tag from html string
      tag = Tag.new(tag_source)
      # connect child to parent
      tag.parent = parent if parent
      # connect parent to child
      parent.children << tag
      # get remaining html
      remaining_html = tag_match.post_match
      # recursively call w/ remaining html
      parse(remaining_html, tag)
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

test
