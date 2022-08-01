#app/controllers/members_controller.rb
class MembersController < ApplicationController 
    before_action :authenticate_user!

    def show 
        user = get_ser_from_token
        render json: {
            status: 'success'
            message: "You are logged in",
            user: user
        }
    end

    private
    def get_user_from_token
        # Decode auth header token.
        secret_key = Rails.application.credentials.devise[:jwt_secret_key]
        split token = request.headers['Authorization'].split(' ')[1]
        jwt_payload = JWT.decode(split_token, secret_key).first
        
        user_id = jwt_payload['sub']
        user = User.find(user_id.to_s)
    end