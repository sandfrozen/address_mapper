class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]

  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
    @hash = Gmaps4rails.build_markers(@businesses) do |business, marker|
      marker.lat business.latitude
      marker.lng business.longitude
      marker.infowindow business.name
    end
  end


  def search
    @ilosc = Business.count
    @search_obj = Object.new
    if request.post?
      keyword = params[:keyword1]
      type = params[:type]

      z=0
      d=0
      if keyword.present?
        url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=53.1293971,23.0911713&radius=5000&keyword=' + keyword + '&key=AIzaSyBLO4vd3QDJ-Qu0LqRMHPjj4-Rix69w-oc'
        # if type.present?
        #   url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=53.1293971,23.0911713&radius=5000&type=' + type + '&key=AIzaSyBLO4vd3QDJ-Qu0LqRMHPjj4-Rix69w-oc'
        # end
        response = RestClient.get(url)
        parsed = JSON.parse(response)

        @ary = []
        z = parsed["results"].count

        parsed["results"].each do |obj|


          if Business.where(latitude: obj['geometry']['location']['lat'].to_s, longitude: obj['geometry']['location']['lng'].to_s).blank? then
            d += 1
              Business.create(longitude: obj['geometry']['location']['lng'], latitude: obj['geometry']['location']['lat'], name: obj['name'], address: obj['vicinity'])
          end

        end
        @result = 'Znaleziono: ', z , ' dodano: ', d
        @ilosc = Business.count
      else
        @result = 'puste okienko'
      end
    end
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
  end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = Business.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def business_params
    params.require(:business).permit(:latitude, :longitude, :name, :address)
  end

end
