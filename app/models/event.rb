class Event < ActiveRecord::Base
  attr_accessible :title, :schedule
  belongs_to :user
end
