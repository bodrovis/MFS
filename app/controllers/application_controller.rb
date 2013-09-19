#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = 'Доступ закрыт.'
    redirect_to root_url
  end
end
