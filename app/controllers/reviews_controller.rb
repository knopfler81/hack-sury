class ReviewsController < ApplicationController

  def create
    @trip = Trip.find(params[:trip_id])
    @review = Review.new(review_params)
    @review.trip = @trip
    @review.user = current_user

    if @review.save
      flash[:notice] = 'Review was successfully created.'
      redirect_to @trip
    else
      flash[:notice] = "Error creating review: #{@review.errors}"
      render 'bookings/show'
    end
  end

  private
    def review_params
      params.require(:review).permit(:rating, :description, :best_picture)
    end
end
