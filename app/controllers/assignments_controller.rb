class AssignmentsController < ApplicationController

  def index
    return if params[:phone_number].blank?
    @message = "Numbers must be 10 digits long" and return if params[:phone_number].length != 10
    @message = "Wrong Numbers" and return if params[:phone_number].split('').select{|a|(a.to_i == 0 || a.to_i == 1)}.length > 0
    @words = ElegantNumber.new.combinations(params[:phone_number])
  end

end
