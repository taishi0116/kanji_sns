class ApplicationController < ActionController::Base
  
  def home
    render html: "漢字のSNSじゃ"
  end
end