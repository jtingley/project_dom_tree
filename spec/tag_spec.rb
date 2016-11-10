
require 'tag'

describe Tag do
  let(:type)   { "p" }
  let(:source) { "<#{type} class='foo bar' id='baz'>" }
  let(:tag)    { Tag.new(source: source) }

  describe '.new' do
    it 'returns a tag object' do
      expect(Tag.new(source: "").class).to eq(Tag)
    end
  end

  describe '#source' do
    it 'returns the source string for the tag' do
      expect(tag.source).to eq(source)
    end
  end

  describe '#type' do
    it 'returns the type of the tag' do
      expect(tag.type).to eq(type)
    end
  end

  describe '#id' do
    it 'returns nil if tag does not have id' do
      expect(tag.id).to eq('baz')
    end
  end
end
