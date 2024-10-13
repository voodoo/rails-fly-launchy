class ProfileController < ApplicationController
  allow_unauthenticated_access only: [:index]
  before_action :resume_session, only: [:index]

  def index
    @user = Current.user || Current.root_user
  end
end
