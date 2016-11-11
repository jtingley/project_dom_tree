
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
        # p "tag_match: #{tag_match}"
        # p "content: #{tag_match.post_match}"
        # conver matchdata to string form
        tag_data = parse_opening_tag(tag_match)
        # create new tag from html string
        tag = create_tag(tag_data)
        @root = tag unless parent
        # link parent & child
        link_tags(parent, tag)
        # get remaining html
        remaining_html = tag_match.post_match
        # recursively call w/ remaining html
        return_match = parse(remaining_html, tag)
        if return_match.to_s.start_with?("</")
          p return_match.to_s
          p return_match.post_match
          return return_match.post_match
        else
          html = return_match.post_match
        end
      end
    end while tag_match
  end

  def parse_opening_tag(tag_match)
    tag_source = tag_match.captures[0]
    content = tag_match.to_s.gsub!(tag_source, "")
    # p "Tag source #{tag_source}"
    # p "Content #{content}"
    [tag_source, content]
  end

  def link_tags(parent, child)
    if parent
      child.parent = parent
      parent.children << child
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

  p html.root.children.length
 # p html.root.children
  p html.root.content

  #html.output
end

test
