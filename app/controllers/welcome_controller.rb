class WelcomeController < ApplicationController
  def index
  	 if session[:user_id] == nil
  	render()
else
 id_user =  session[:user_id]
     @user = User.find(session[:user_id])

end
  end
 end

