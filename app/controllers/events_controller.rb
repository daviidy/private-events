class EventsController < ApplicationController
  before_action :authorize, except: [:index, :show]

  def index
    @events = Event.all.order('created_at DESC')
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      flash.notice = 'Event created!'
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:location, :description, :title, :date, :creator_id)
  end
end