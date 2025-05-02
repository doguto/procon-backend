class Api::V1::UsersController < ApplicationController
    def index
        users = Domains::Api::V1::Users::Index.call
        render json: users
    end

    def show
        user = Domains::APi::V1::Users::Show.call(params[:id])
        render json: user
    end
end
