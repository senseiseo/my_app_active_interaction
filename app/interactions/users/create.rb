# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    ATTRIBUTES = %i[surname name email nationality country gender patronymic age].freeze
    ARRAY_ATTRIBUTES = %i[interests skills].freeze

    ATTRIBUTES.each { |attr| string attr }
    ARRAY_ATTRIBUTES.each { |attr| array attr, default: [] }
    integer :age

    validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
    validates :email, presence: true
    validates :gender, inclusion: { in: %w[male female other] }

    def execute
      ActiveRecord::Base.transaction do
        user = User.create!(user_attributes)
        assign_associations(user)
        user
      end
    end

    private

    def user_attributes
      inputs.slice(*ATTRIBUTES).merge(full_name: [surname, name, patronymic].compact.join(' '))
    end

    def assign_associations(user)
      ARRAY_ATTRIBUTES.each do |attr|
        associated_class = attr.to_s.singularize.capitalize.constantize
        user.public_send(attr) << associated_class.where(name: public_send(attr))
      end
    end
  end
end
