object @shelter
attributes :url_id, :id, :name, :phone, :state, :address1, :email, :city, :zip
node(:request_pets_count) { |m| @count }
node(:pet_count) { |m| @shelter.pets.count }
node(:updated_count) { |m| @updated_count }
node(:added_count) { |m| @added_count }
