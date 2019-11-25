class UpdateBillboardJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Perform every day at 00:00
    Billboard.update_params
  end


end
