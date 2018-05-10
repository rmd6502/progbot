require 'pry'

class SessionsController < ApplicationController

  def create
    @user = User.find_or_create_by(slack_userid: auth['uid']) do |u|
      if auth['info']['user']
        u.slack_username = auth['info']['user']
      end
    end

    session[:user_id] = @user.id
    render 'welcome/dashboard'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
