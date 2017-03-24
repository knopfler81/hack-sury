class ProspectsController < ApplicationController
  def create
    @prospect = Prospect.new(prospect_params)
    if @prospect.save
      #envoyer email Alexis
      #envoyé email prospect
      redirect_to root_path
    else
      render "root"
    end
  end

  private
    def prospect_params
      params.require(:prospect).permit(:email)
    end
end
