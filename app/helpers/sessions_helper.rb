module SessionsHelper
  def sign_in(user)
    session[:user] = user.id
  end

  def sign_out
    session.delete(:user)
  end

  def current_user
    if session[:user]
      User.find_by_id(session[:user])
    else
      nil
    end
  end

  def redirect_back_or(path)
    if request.referer
      redirect_to request.referer
    else
      redirect_to path
    end
  end
end