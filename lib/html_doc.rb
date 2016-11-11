
require_relative 'tag'

class HTMLDoc
  attr_reader   :root
  attr_accessor :file_path

  # match up to not including next tag - how?
  # currently OPENT_TAG will bug on #'s or <
  OPEN_TAG = /\A(<.*?>)[\w\s]+/
  CLOSE_TAG = /\A<\/.*?>/

  def initialize(args = {})
    @file_path = args.fetch(:path)
    @root
  end

  def create_tag(tag_data)
    tag_source, content = tag_data
    Tag.new(s: tag_source, c: content)
  end

  def formatted_html
    read_result = unformatted_html
    read_result.gsub(/\n\s+{0,}/, '')
  end

  def output
  end

  def parse(html = formatted_html, parent = nil)
    close_match = html.match(CLOSE_TAG)
    return close_match if close_match
    begin
      tag_match = html.match(OPEN_TAG)
      if tag_match
        # conver matchdata to string form
        tag_data = parse_opening_tag(tag_match)
        # create new tag from html string
        @root = tag = create_tag(tag_data) unless parent
        # link parent & child
        link_tags(parent, tag)
        # get remaining html
        remaining_html = tag_match.post_match
        # recursively call w/ remaining html
        return_match = parse(remaining_html, tag)
        if return_match.to_s.start_with?("</")
          return return_match
        else
          html = return_match.post_match
        end
      end
    end while tag_match
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

  # ensure file reading/ formatting works
  #p html.formatted_html

  # test tree building
  html.parse

  p html.root

  #html.output
end

test
