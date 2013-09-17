class SessionsController < ApplicationController
  def create
    #render text: request.env['omniauth.auth'].to_yaml
    user_info = request.env['omniauth.auth']
    uid = user_info['uid']
    user = User.find_or_initialize_by_uid(uid)

    user.provider = user_info['provider']
    user.name = user_info['info']['name']
    user.nickname = user_info['info']['nickname']
    user.image_url = user_info['info']['image']
    user.profile_url = user_info['info']['urls']['Twitter']
    user.token = user_info['credentials']['token']
    user.secret = user_info['credentials']['secret']

    user.save
    sign_in user

    redirect_to root_path
  end

  def destroy
    if current_user
      sign_out
    end

    redirect_back_or root_path
  end
end