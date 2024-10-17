# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def create
      result = Users::Create.run!(user_params)

      result.success? ? render_success(result.value) : render_error(result.errors)
    end

    private

    def render_success(user)
      render json: { user: user }, status: :created
    end

    def render_error(errors)
      render json: { errors: errors }, status: :unprocessable_entity
    end

    def user_params
      params.require(:user).permit(
        :name, :patronymic, :email, :surname, :age, :nationality, :country, :gender,
        interests: [], skills: []
      )
    end
  end
end
