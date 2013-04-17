module DataMapper
  class Collection
    # Use already loaded array instead of querying the database for each call.
    def first_program(opts = {})
      raise ArgumentError, 'day_of_week and start_hour or end_hour are required' unless opts[:day_of_week] && (opts[:start_hour] || opts[:end_hour])
      self.each do |program|
        return program if program.day_of_week == opts[:day_of_week] && (program.start_hour == opts[:start_hour] || program.end_hour == opts[:end_hour])
      end
      nil
    end
  end
end