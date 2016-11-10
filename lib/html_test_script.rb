
require_relative 'tag'

file_path = 'html/tiny.html'

NEW_TAG_CONTENT_PATTERN = /\A(<.*?>)[\w\s]+/

def test(file_path)

  read_result = File.read(file_path)

  read_result.gsub!(/\n\s+{0,}/, '')

  match = read_result.match(NEW_TAG_CONTENT_PATTERN)

# this demonstrates match.capture functionality
  p match.captures
  p match.to_s
  #p Tag.new(source: match.to_s)
  #p "Match: #{match}"
  #p "Post Match: #{match.post_match}"
end

test(file_path)
