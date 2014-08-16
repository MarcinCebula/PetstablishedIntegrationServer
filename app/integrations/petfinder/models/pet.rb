module PetfinderIntegration
  module Models
    class Pet
      attr_accessor :options, :breeds, :shelter_pet_id, :status, :name, :contact, :description, :sex, :age, :size, :mix, :shelter_id, :last_update, :media, :id, :animal, :images

      def initialize(data)
        @data = data
      end

      private
      def run
        clean_hash = cleanup(data, ['media'])
        clean_hash['media'] = clean_media(data)
        apply_translations(clean_hash)
        set_instance_variables(clean_hash)
      end
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
      def images
        # @media['images']
      end

      def clean_media(data)
        return {
          'images' => clean_images(data['media'])
        }
      end
      def cleanup_images(media_data)
        return [] if media_data['photos'].length == 0
        return [] if media_data['photos']['photo'].length == 0

        photos = media_data['photos']['photo']
        ids = photos.map { |img| img['@id'] }.uniq
        image_sets = ids.map { |id| photos.select { |img| img ? img['@id'] == id : nil } }

        image_sets.map do |image_set|
          image_hash = {}
          image_set.each do |img|
            image_id = image_size_translation(img['@size'])
            image_hash[image_id] = {
              'url' => img['$t'],
              'size'=> img['@size'],
              'id' => img['@id'].to_i
            }
          end
          image_hash
        end
      end
      def apply_translations(hash)
        hash['status'] = apply_translation_for_status(hash)
        hash
      end

      def image_size_translation(size)
        case size
        when 't'
          return 'thumbnail'
        when 'pnt'
          return 'tiny'
        when 'fpm'
          return 'small'
        when 'pn'
          return 'medium'
        when 'x'
          return 'large'
        end
      end
      # A=adoptable, H=hold, P=pending, X=adopted/removed
      def apply_translation_for_status(hash)
        status = hash['status']
        case status
        when 'A'
          return { 'value' => 'A', 'verbose' => 'adoptable' }
        when 'H'
          return { 'value' => 'H', 'verbose' => 'hold' }
        when 'P'
          return { 'value' => 'P', 'verbose' => 'pending' }
        when 'X'
          return { 'value' => 'X', 'verbose' => 'adopted/removed' }
        else
          return { 'value' => '', 'verbose' => 'unknown' }
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
    end
  end
end
