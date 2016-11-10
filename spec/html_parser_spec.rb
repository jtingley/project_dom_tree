
require 'html_parser'

describe HTMLParser do
  let(:html_parser) { HTMLParser.new }

  describe '#parse_tag' do
    it 'returns hash with keys, values for tag attribute & values' do
      p_tag = "<p class='foo bar' id='baz' name='fozzie'>"
      parsed_p = { "class" => ["foo", "bar"], "id" => ["baz"],
                     "name" => ["fozzie"], "type" => "p"}
      expect(html_parser.parse_tag(p_tag)).to eq(parsed_p)
      hr_tag = "<hr class='foo' />"
      parsed_hr = { "type" => "hr", "class" => ["foo"] }
      expect(html_parser.parse_tag(hr_tag)).to eq(parsed_hr)
    end
  end

end
