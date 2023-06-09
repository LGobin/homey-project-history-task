# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :notice, :alert

  before_action :authenticate_user!
end
