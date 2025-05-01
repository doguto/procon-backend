class Api::V1::ProfilesController < ApplicationController
    def show
        profile = Profile.find_by(user_id: params[:id])
        render json: profile
    end
end
