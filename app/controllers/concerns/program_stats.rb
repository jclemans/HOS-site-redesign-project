module ProgramStats
  extend ActiveSupport::Concern

  def program_count
    @program_count ||= Program.active.count
    @program_count
  end
end
