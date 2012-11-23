class EventsController < ApplicationController

  before_filter :get_user
  respond_to :html, :js, :json

  def new
    if cannot? :manage, Event
      respond_to do |format|
        format.js { render :new do |page|
          page << "$('#calendar').fullCalendar( 'refetchEvents' )"
        end }
        format.html { redirect_to :action => :index }
      end
    else
      startDate = Time.now.beginning_of_hour
      @event = Event.new(:owner_id => current_user.id, :starttime => startDate, :endtime => 1.hour.since(startDate), :period => "Does not repeat")
      @event.starttime = Time.parse(params[:start_time][0,21]) if params[:start_time]
      @event.endtime = Time.parse(params[:end_time][0,21]) if params[:end_time]
      @event.all_day = params[:all_day] if params[:all_day]
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def create
    success = false
    if params[:event][:period] == "Does not repeat"
      @event = Event.new(params[:event])
      success = @event.save
    else
      @event_series = EventSeries.new(params[:event])
      success = @event_series.save
    end
    respond_to do |format|
      format.html do
        if success
          redirect_to :action => :index
        else
          #flash.alert = t('activemodel.notice.could_not_create', :model => Event.model_name.human)
          render :action => :new
        end
      end
      format.js do
        if success
          render :action => :create
        else
          #flash.alert = t('activemodel.notice.could_not_create', :model => Event.model_name.human)
          render :action => :new
        end
      end
    end
  end

  def index
  end


  def show
    @events = Event.all :conditions => ["starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"]
    events = []
    @events.each do |event|
      the_cat = event.category.present? ? event.category : 'none'
      events << {:id => event.id, :title => event.title, :category => the_cat, :place => event.place, :description => event.description || "Some cool description here...", :start => "#{event.starttime.iso8601}", :end => "#{event.endtime.iso8601}", :allDay => event.all_day, :recurring => (event.event_series_id)? true: false}
    end
    render :text => events.to_json
  end

  def move
    if can? :manage, Event
      @event = Event.find_by_id params[:id]
      if @event
        if params[:event][:event_selection] == 'true' # gesamte Event-serie
          @event.event_series.starttime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.starttime))
          @event.event_series.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
          @event.event_series.all_day = params[:all_day]
          @event.event_series.save
        end

        @event.starttime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.starttime))
        @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
        @event.all_day = params[:all_day]
        @event.save
      end
   end
  end


  def resize
    if can? :manage, Event
      @event = Event.find_by_id params[:id]
      if @event
        @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
        @event.save
      end
    end
  end

  def edit
    @event = Event.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.js do
        render :edit do |page|; page << "$(#desc_dialog').html(<%= escape_javascript(render(partial: 'form'))%>);" end
      end
    end
  end

  def update
    if can? :manage, Event
      ev_id = params[:event][:id]
      ev_id = params[:id] if ev_id.nil?
      @event = Event.find_by_id(ev_id)
      if params[:event][:commit_button] == "Update All Occurrence"
        @events = @event.event_series.events
        @event.update_events(@events, params[:event])
      elsif params[:event][:commit_button] == "Update All Following Occurrence"
        @events = @event.event_series.events.all(:conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
        @event.update_events(@events, params[:event])
      else
        @event.attributes = params[:event]
        @event.save
      end
    end
    respond_to do |format|
      format.html do
        redirect_to :action => :index
      end
      format.js
    end
  end

  def destroy
    if can? :manage, Event
      @event = Event.find(params[:id])
      if params[:event][:event_selection] == 'true' # gesamte Event-serie
        @event.event_series.destroy
      elsif params[:event][:event_selection] == 'future' # alle zukünftigen Events (ohne diesen!)
        @events = @event.event_series.events.all(:conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
        @event.event_series.events.delete(@events)
      else # NUR diesen Event (unabhängig, ob single Event oder Teil einer Serie)
        @event.destroy
      end
    end
    render :action => :destroy
  end

  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
    @can_manage = can? :manage, Event
  end


end
