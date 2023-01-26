class ApplicationController < ActionController::Base
  include Internationalization
  include Authentication
  include ErrorHandling

  add_flash_types :info, :danger, :warning, :success, :alert, :notice
end
