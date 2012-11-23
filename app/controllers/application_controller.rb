class ApplicationController < ActionController::Base

  protect_from_forgery

  after_filter :flash_to_headers

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def respond_to_not_found(*types)
    flash[:warning] = t(:msg_asset_not_available, asset)

    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.js   { render(:update) { |page| page.reload } }
      format.json { render :text => flash[:warning], :status => :not_found }
      format.xml  { render :text => flash[:warning], :status => :not_found }
    end
  end

  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Flash-Notice-Message'] = flash[:notice]  unless flash[:notice].blank?
    response.headers['X-Flash-Error-Message'] = flash[:error]  unless flash[:error].blank?
    # repeat for other flash types...

    flash.discard  # don't want the flash to appear when you reload page
  end
end
