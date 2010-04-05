class SenseiController < ApplicationController
  def index
    @units = Unit.all
    respond_to do |format|
      format.html
    end
  end
end
