class UploadStockJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts 'Well I am here to upload stock'
  end
end
