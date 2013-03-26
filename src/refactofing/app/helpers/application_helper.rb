# coding:utf-8

module ApplicationHelper
  def get_icon(recipe)
    url = "/uploads/recipe/image/" + recipe.id.to_s + "/icon.jpg"
    if !File.exist?("public/" + url)
      return nil
    end
    return image_tag(url, :alt => "Obrázek receptu")
  end

  def get_thumb_icon(recipe)
    url = "/uploads/recipe/image/" + recipe.id.to_s + "/thumb_icon.jpg"
    if !File.exist?("public/" + url)
      url = asset_path("no_photo_small.jpg")
    end
    return image_tag(url, :alt => "Náhled")
  end

  def is_activated(user)
    return user.activation_state == "active"
  end

  def is_admin(user)
    if user.kind_of? User
      return current_user.id == user.id
    end
    if user.kind_of? String
      return current_user.id == user.to_i
    end
    return user <= 1
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

  def get_att_str(att)
    if (att != nil)
      return att.to_s
    end
    return 'neuvedeno'
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
        show_list_ingredience_categories
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
end
