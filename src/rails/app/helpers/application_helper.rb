module ApplicationHelper
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

  def show_left_panel
    # podminky, kdy se leve menu zobrazovat bude - je jich jen par
    if (params[:controller] == "recipe" && params[:action] == "show")
      return true
    end
    # pokud nejsou splneny podminky pro zobrazeni, je leve menu schovano
    return false
  end

  def get_content_class
    # trida obsahu zavisi na tom, zda je zobrazeno leve menu. Pokud ne, je zleva odsazen
    return show_left_panel ? "span8 offset2" : "span10 offset1"
  end

  def render_self_than_global(template)
#    return exists?(params[:controller], "links")
    return render template rescue render ("layouts/" + template)
  end

  def get_filter(name)
    return params["filter"] != nil && params["filter"][name] != nil ?
      params["filter"][name] : nil
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
end
