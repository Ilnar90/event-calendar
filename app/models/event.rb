class Event < ActiveRecord::Base
  attr_accessible :title, :all_day, :starts_at, :ends_at, :class_name, :editable,
  :start_editable, :duration_editable, :color, :background_color, :border_color, :text_color, :description, :schedule
  validates :title, :schedule
  scope :between, lambda {|start_time, end_time|
   {:conditions => ["? < starts_at < ?", Event.format_date(start_time), Event.format_date(end_time)] }
  }
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def as_json(options = {})
   {
    :id => self.id,
    :title => self.title,
    :description => self.description || "",
    :start => starts_at.rfc822,
    :end => ends_at.rfc822,
    :allDay => self.all_day,
    :recurring => false,
    :url => Rails.application.routes.url_helpers.event_path(id),
   }  
  end

  def init_schedule(params) 
    event_start_at = params[:starts_at]
    event_end_at = params[:ends_at]
    recurring_event = params[:recurring_event]
    period = params[:period]

    if recurring_event
      schedule = IceCube::Schedule.new( event_start_at, :end_time => event_end_at ) do |s|
        s.add_recurrence_rule IceCube::Rule.send(period).until(event_end_at) 
      end
    else
      schedule = IceCube::Schedule.new(event_start_at) 
    end 

    self.schedule = schedule.to_yaml
  end 
end
