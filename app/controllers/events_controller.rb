class EventsController < ApplicationController
  def index  
    @events = Event.scoped  
    @events = Event.between(params['start'], params['end']) 
    if params['start'] && params['end']  
      respond_to do |format|  
      format.html # index.html.erb  
      format.json { render :json => @events }  
    end  
  end

  def edit
  
  end
  
  def update
  	@events = Event.find(params[:id])
    if
      @events.update(events_params)
      redirect_to @events
    else
      render 'edit'
  end 
end  