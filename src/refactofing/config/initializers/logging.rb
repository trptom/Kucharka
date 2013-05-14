LOGGER = {
  :page_requests => Logger.new(Rails.root.join("log", Rails.env + "_page_requests.log"))
}