class LandingPageController < ApplicationController

  def home
    render layout: 'landing_page'
  end

  def price

  end

  def contact
    LandingPageContactMailerJob.perform_later(params[:name], params[:email], params[:message])

    respond_to do |format|
      format.json { render :json => 'Mensagem enviada!'.to_json }
    end
  end
end
