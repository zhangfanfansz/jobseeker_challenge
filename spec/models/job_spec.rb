# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'associations' do
    it { should have_many(:tag_matches) }
  end
end
