  class EventsController < ApplicationController
  
  respond_to :html, :json

  def new
    @event = Event.new
  end

  def create
    @event = Event.new
    @event.title = params[:event_title]
    @event.user = current_user
    @event.init_schedule(params)
    if @event.save
      redirect_to root_path, :flash => { :success => "Event was succesfully created" }
    else
      render action: "new" 
    end
  end

  def index
    @events = Event.all
    respond_with @events
  end

  def edit
    @event = Event.find(params[:id])
    @method = :put
    schedule  = IceCube::Schedule.from_yaml(@event.schedule)
    @begin_date = schedule.start_time.to_s 
    @end_date = schedule.end_time.to_s
    @recurring = !schedule.recurrence_rules.empty? 
    @period = ""
    %w[daily weekly monthly yearly].each do |p|
      @period = p if schedule.recurrence_rules.first.to_s.downcase.include? p   
    end
  end

  def update
  	@event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @event = Event.find(params[:id])
    respond_with @event
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end 
end