class ProfilepageController < ApplicationController
  def index
  end
  def article_params
    params.require(:user).permit(:image)
  end
end
