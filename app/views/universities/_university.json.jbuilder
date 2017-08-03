json.extract! university, :id, :user_id, :url, :name, :description, :image, :address, :latitude, :longitude, :facebook, :twitter, :linkedin, :created_at, :updated_at
json.url university_url(university, format: :json)
