class LandingPageController < ApplicationController

  def home
    render layout: 'landing_page'
  end

  def contact
    LandingPageMailer.contact(params[:name], params[:email], params[:message]).deliver_now

    respond_to do |format|
      format.json { render :json => 'Mensagem enviada!'.to_json }
    end
  end
end
