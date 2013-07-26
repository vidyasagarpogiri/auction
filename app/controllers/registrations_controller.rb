class RegistrationsController < Devise::RegistrationsController
  layout :determine_layout

  private
  def determine_layout
    params[:action]=="edit" ? "useradmin" : "application"
  end
end