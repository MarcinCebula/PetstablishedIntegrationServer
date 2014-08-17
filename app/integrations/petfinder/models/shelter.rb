module PetfinderIntegration
  module Models

    class Shelter
      attr_accessor :country, :longitude, :latitude, :name, :phone, :state, :address1, :address2, :email, :city, :zip, :fax, :id

      def initialize(data)
        @data = data
      end
      def run
        clean_hash = cleanup(@data, ['media'])
        set_instance_variables(clean_hash)
        self
      end

      private




      #------------------ Might want to extract this ------------------
      def cleanup(pet_data, exclude=[])
        data = exclude_keys(pet_data.dup, exclude)
        clean_hash = {}
        data.each do |field|
          key = field[0]
          value = field[1]
          if is_plural? key
            result = value.empty? ? [] :
              value.first.count > 1 ? value.map(&:second).flatten.map { |f| f.first[1] } : value.map(&:second)
          else
            result = value.empty? ? "" :
              value.count > 1 ?  Hash[value.map { |f| {f.first => f[1]['$t'] || ""} }.map(&:flatten)] : value['$t']
          end
          clean_hash[key.underscore.to_s] = result
        end
        clean_hash
      end
      def set_instance_variables(hash)
        hash.each do |variable, value|
          instance_variable_set("@#{variable}", value)
        end
      end
      def exclude_keys(hash, exclude)
        exclude.each do |exclude_field|
          hash.delete_if { |key| key == exclude_field }
        end
        hash
      end
      def is_plural?(str)
        str.pluralize == str
      end
      #------------------------ end --------------------------------
    end

  end
end
