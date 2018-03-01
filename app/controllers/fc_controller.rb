class FcController < ApplicationController

  def index
    #do nothing yet
  end

  def home
    #default, load home
  end

  def register
    #do nothing yet
  end

  def profile
    #do nothing yet
  end

  def show
    redirect_to index_path
  end

end