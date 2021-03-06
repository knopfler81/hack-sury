class NotificationsController < ApplicationController
  def show
    @notification = Notification.find(params[:id])
    @notification.mark_as_read
    redirect_to @notification.topic.trip
  end
end
