class EventsController < ApplicationController
  def new
    @event = Event.new
    respond_with @event
  end

  def create
    @event = Event.new
    @event.title = params[:event_title]
    @event.user = current_user
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
    respond_with @event
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
