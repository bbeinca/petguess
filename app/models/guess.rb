class Guess < ActiveRecord::Base
  validates :height,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :weight,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :guessvalue,
            presence: true,
            inclusion: { in: %w(dog cat),
                         message: "%{value} is not a valid pet type" }

  # TODO - this creates problems currently, but can be re-enabled once the refactoring
  # is complete to only commit when all data is present
  #validates :actualvalue,
            #inclusion: { in: %w(dog cat),
             #            message: "%{value} is not a valid pet type" }

  def as_json(options={})
    super()

    # once UUID added, we should exclude ID as we don't want to leak that
    # to the client
    #
    # super(:only => [:uuid,:height,:weight,:guessvalue,:actualvalue])
  end
end
