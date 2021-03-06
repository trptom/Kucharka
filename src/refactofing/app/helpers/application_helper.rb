# coding:utf-8

module ApplicationHelper
  def get_icon(recipe)
    return recipe.image_url(:standard) ?
      image_tag(recipe.image_url(:standard), :alt => "Obrázek receptu") :
      nil
  end

  def get_thumb_icon(recipe)
    return recipe.image_url(:thumb) ?
      image_tag(recipe.image_url(:thumb), :alt => "Náhled") :
      image_tag(asset_path "thumb_icon.jpg", :alt => "Náhled")
  end

  def is_activated(user)
    return user.activation_state == "active"
  end

  def is_admin(user)
    if user.kind_of? User
      return user.username == "admin"
    end
    if user.kind_of? String
      return User.find(user.to_i).username == "admin"
    end
    return User.find(user).username == "admin"
  end

  def is_current_user(user)
    if (current_user == nil) || (user == nil)
      return false
    end

    if user.kind_of? Numeric
      return current_user.id == user
    end
    if user.kind_of? String
      return current_user.id == user.to_i
    end

    return user.id == current_user.id
  end

  def print_bool(bool)
    return (bool ? "ano" : "ne")
  end

  def get_filter(name)
    return params["filter"] != nil && params["filter"][name] != nil ?
      params["filter"][name] : nil
  end

  def is_numeric?(obj)
     obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
  
  ###################
  # FUNKCE PRO MENU #
  ###################

  def show_lists_dropdown
    return show_list_users ||
        show_list_marks ||
        show_list_ingrediences ||
        show_list_recipe_categories ||
        show_list_ingredience_categories ||
        show_list_logs
  end

  def show_list_users
    return users_filter("index", nil)
  end
  def show_list_marks
    return marks_filter("index", nil, nil)
  end

  def show_list_ingrediences
    return ingrediences_filter("index", nil, nil)
  end

  def show_list_recipe_categories
    return recipe_categories_filter("index", nil, nil)
  end

  def show_list_ingredience_categories
    return ingredience_categories_filter("index", nil, nil)
  end

  def show_list_logs
    return logs_filter("index", nil)
  end

  ##############################################################################
  # pro komponenty
  ##############################################################################

  def get_recipe_level_options
    ret = Array.new
    for i in 0..(LEVEL_TEXT.length-1)
      ret << [LEVEL_TEXT[i], i.to_s]
    end
    return ret;
  end

  ##############################################################################
  # logovani
  ##############################################################################

  def get_log_prefix
    return current_user ?
       (l DateTime.now, :format => :long) + " (" + current_user.username + "@" + request.remote_ip + "): " :
       (l DateTime.now, :format => :long) + " (" + request.remote_ip + "): "
  end

  def get_current_url
    return "#{request.method} #{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end
end
