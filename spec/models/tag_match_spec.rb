# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagMatch, type: :model do
  let(:tag) { create(:tag) }
  let(:taggable) { create(:jobseeker) }
  let(:taggable2) { create(:job) }

  it 'is valid with valid attributes' do
    tag_match = TagMatch.new(tag: tag, taggable: taggable)
    expect(tag_match).to be_valid
    tag_match2 = TagMatch.new(tag: tag, taggable: taggable2)
    expect(tag_match2).to be_valid
  end

  it 'is not valid without a tag' do
    tag_match = TagMatch.new(tag: nil, taggable: taggable)
    expect(tag_match).not_to be_valid
    tag_match2 = TagMatch.new(tag: nil, taggable: taggable2)
    expect(tag_match2).not_to be_valid
  end

  it 'is not valid without a taggable' do
    tag_match = TagMatch.new(tag: tag, taggable: nil)
    expect(tag_match).not_to be_valid
  end

  it 'belongs to a tag' do
    expect(TagMatch.reflect_on_association(:tag).macro).to eq(:belongs_to)
  end

  it 'belongs to a taggable' do
    expect(TagMatch.reflect_on_association(:taggable).macro).to eq(:belongs_to)
  end
end
