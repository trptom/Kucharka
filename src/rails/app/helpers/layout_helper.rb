module LayoutHelper
  def layout
    # akce bez layoutu
    if ((params[:controller] == "ingrediences" && params[:action] == "new_request") ||
          (params[:controller] == "ingrediences" && params[:action] == "plain_list"))
      return false;
    end

    return "application"
  end
end
