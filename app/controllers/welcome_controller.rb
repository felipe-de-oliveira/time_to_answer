class WelcomeController < ApplicationController
  http_basic_authenticate_with name: "felipe", password: "felipe123"
  
  def index
  end
end
