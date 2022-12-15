require_relative './lat_long'

module NDH
  module Position
    def position
      coords = COORDINATES[address.lines.first]
      return if coords.blank?

      {
        longitude: coords[:x],
        latitude: coords[:y]
      }
    end
  end
end
