module TripsHelper
  def guests_collection
    (1..4).map do |i|
      ["#{i} travelers", i]
    end
  end
end

