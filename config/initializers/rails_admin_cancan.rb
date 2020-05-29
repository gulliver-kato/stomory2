require 'rails_admin/main_controller'

module RailsAdmin

  class MainController < RailsAdmin::ApplicationController
    rescue_from CanCan::AccessDenied do |exception|
      flash[:alert] = '管理画面は管理人のみ閲覧可能です。'
      redirect_to main_app.root_path
    end
  end
end