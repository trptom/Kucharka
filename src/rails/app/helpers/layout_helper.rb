module LayoutHelper
  def layout
    # akce bez layoutu
    if ((params[:controller] == "ingrediences" && params[:action] == "plain_list") ||
          (params[:controller] == "home" && params[:action] == "plain_message"))
      return nil;
    end

    return "application"
  end
end
