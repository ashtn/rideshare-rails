class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def create
    #raise
    #Find random driver and assign it to user, as well as start with a rating of 0
    #user_id = user making new trip
    #cost functionality
    #Date.today for date
    #Trip will not be saved if last Trip object has rating of 0

    # @trip = Trip.create(trip_params)
    ##param is empty , how to
    #user = User.find(find_user)
    last_trip = find_user.trips.last

    trip = Trip.new
    trip[:user_id] = params[:id]
    trip[:rating] = 0
    trip[:date] = Date.today
    trip[:driver_id] = Driver.find_driver

    if last_trip.rating == 0
      # redirect_to edit_rating_path(last_trip.id)
      # redirect_to last_trip_path
      redirect_to edit_rating_path(last_trip.id)
    elsif trip.save
      redirect_to edit_rating_path(trip.id)
    else
      render "new"
    end
  end

  def edit_rating
    @trip = Trip.find(params[:id])
    @trip.rating = [:trip][:rating]

    redirect_to user_path(@trip.user_id)
  end

  # def new
  #   @trip = Trip.new
  # end

  def show
    @trip = Trip.find(params[:id])
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])

    if @trip.update trip_params
      ##########################
      #@trip.id or @trip.user.id
      ##########################
      redirect_to user_path(@trip.id)
    else
      render "edit"
    end
  end

  def destroy
    Trip.destroy(params[:id])
    redirect_to trips_path
  end

  private
  def trip_params
    params.require(:trip).permit(:driver_id, :user_id, :rating)
  end

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
