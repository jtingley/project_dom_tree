
require_relative 'tag'

file_path = 'html/tiny.html'

def test(file_path)

  read_result = File.read(file_path)

  read_result.gsub!(/\n\s+{0,}/, '')

  match = read_result.match(/<.*?>/)

  p Tag.new(source: match.to_s)

  p "Match: #{match}"

  p "Post Match: #{match.post_match}"
end

test(file_path)
