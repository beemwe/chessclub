class Mercury::ImagesController < MercuryController

  # respond_to :json

  # POST /images.json
  def create
    @image = Mercury::Image.new(params[:image])
    @image.save
    antwort = "{\"url\":\"#{@image.url(:medium)}\"}"
    Rails.logger.info " Antwort: #{antwort}"
    respond_to do |format|
      format.json { render :text => antwort }
    end
  end

  # DELETE /images/1.json
  def destroy
    @image = Mercury::Image.find(params[:id])
    @image.destroy
    respond_with @image
  end

end
