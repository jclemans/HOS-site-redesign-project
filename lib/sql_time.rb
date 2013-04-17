=begin
module DataMapper
  module Types
    class SqlTime < DataMapper::Type
      primitive String

      def self.load(value, property)
        value
      end
      
      def self.dump(value, property)
        value
      end
    end
  end
end
=end