class RecordsController < ApplicationController
  def index
  end

  def new
    @record = Record.new
    @users = User.all
  end

  def create
    render :index
  end
  
  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
