module LayoutHelper
  def layout
    # akce bez layoutu
    if ((params[:controller] == "ingrediences" && params[:action] == "new_request") ||
          (params[:controller] == "ingrediences" && params[:action] == "plain_list") ||
          (params[:controller] == "recipes" && params[:action] == "add_connected_article") ||
          (params[:controller] == "recipes" && params[:action] == "remove_connected_article") ||
          (params[:controller] == "marks" && params[:action] == "create"))
      return false;
    end

    return "application"
  end
end
