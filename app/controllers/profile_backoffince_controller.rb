class ProfileBackoffinceController < ApplicationController
    before_action :authenticate_profile!
    layout 'profile_backoffice'
end
