# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'is valid with a unique tag_code_name' do
    tag = create(:tag)
    expect(tag).to be_valid
  end

  it 'is invalid with a duplicate tag_code_name' do
    create(:tag, tag_code_name: 'duplicate_code_name')
    duplicate_tag = build(:tag, tag_code_name: 'duplicate_code_name')

    expect(duplicate_tag).not_to be_valid
    expect(duplicate_tag.errors[:tag_code_name]).to include('has already been taken')
  end
end
