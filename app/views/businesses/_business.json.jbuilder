json.extract! business, :id, :latitude, :longitude, :name, :address, :created_at, :updated_at
json.url business_url(business, format: :json)
