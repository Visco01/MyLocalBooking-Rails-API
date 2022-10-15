class Api::TestJwtController < ApplicationController
  def index
    render plain: "Test JSON Web Token passato!!"
  end
end
