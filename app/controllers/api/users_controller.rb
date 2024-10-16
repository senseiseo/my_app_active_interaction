module Api
  class UsersController < ApplicationController
    def create

    end

    private

    def user_params
      params.require(:user).permit(:name, :patronymic, :email, :surname, :age, :nationality, :country, :gender, interests: [], :skils)
    end
  end
end
