# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create, type: :interaction do
  describe '#execute' do
    let(:valid_attributes) do
      {
        name: 'Adel',
        patronymic: 'Isildurovish',
        surname: 'Safin',
        email: 'safin@example.com',
        age: 36,
        nationality: 'Tatarstan',
        country: 'Russia',
        gender: 'male',
        interests: %w[Reading Hiking],
        skills: %w[Ruby Rails]
      }
    end

    context 'with valid attributes' do
      it 'creates a new user' do
        outcome = described_class.run(valid_attributes)

        expect(outcome).to be_valid
        expect(outcome.result).to be_persisted
        expect(outcome.result.full_name).to eq('Safin Adel Isildurovish')
      end

      it 'associates interests' do
        Interest.create(name: 'Reading')
        Interest.create(name: 'Hiking')

        outcome = described_class.run(valid_attributes)

        expect(outcome.result.interests.pluck(:name)).to match_array(%w[Reading Hiking])
      end

      it 'associates skills' do
        Skill.create(name: 'Ruby')
        Skill.create(name: 'Rails')

        outcome = described_class.run(valid_attributes)

        expect(outcome.result.skills.pluck(:name)).to match_array(%w[Ruby Rails])
      end
    end

    context 'with invalid attributes' do
      it 'returns errors for invalid age' do
        attributes = valid_attributes.merge(age: 100)
        outcome = described_class.run(attributes)

        expect(outcome).not_to be_valid
        expect(outcome.errors[:age]).to be_present
      end

      it 'returns errors for invalid gender' do
        attributes = valid_attributes.merge(gender: 'invalid')
        outcome = described_class.run(attributes)

        expect(outcome).not_to be_valid
        expect(outcome.errors[:gender]).to be_present
      end

      it 'raises an error for non-unique email' do
        described_class.run(valid_attributes)

        expect do
          described_class.run(valid_attributes)
        end.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
end
