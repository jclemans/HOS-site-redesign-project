module AntiSpamValidations
  extend ActiveSupport::Concern
  
  included do
    attr_accessor :blue_meanies
    validate :anti_spam_validation, on: :create
  end

  def anti_spam_validation
    if blue_meanies.to_s.downcase != 'blue'
      errors.add(:blue_meanies, "is not correct.")
    end
  end

end
