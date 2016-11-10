require_relative 'tag'

read_result = File.read('test.html')

read_result.gsub!(/\n\s+{0,}/, '')

match = read_result.match(/<.*?>/)

p Tag.new(source: match.to_s)

p "Match: #{match}"
p "Post Match: #{match.post_match}"