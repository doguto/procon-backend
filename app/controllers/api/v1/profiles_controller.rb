class Api::V1::ProfilesController < ApplicationController
    def show
        profile = Domains::Api::V1::Profiles::Show.call(params[:id])
        render json: profile
    end
end
