class ListenerStat
  include DataMapper::Resource
  property :id, Serial
  property :program_id, Integer
  property :listeners, Integer
  property :created_at, DateTime

  belongs_to :program
end
