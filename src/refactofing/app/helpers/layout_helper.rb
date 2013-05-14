module LayoutHelper
  def layout
    if (params[:controller] == "logs" && params[:action] == "detail")
      return nil
    end

    return "application"
  end
end
