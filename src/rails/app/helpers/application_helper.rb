module ApplicationHelper

  def is_admin(user)
    return user.has_role?(:admin)
  end

  def is_current_user(user)
    return user.id == current_user.id
  end

  def has_permission(user, permission)
    return ((user.permission & permission) != 0)
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

  def show_fridge
    # podminky, kdy se lednicka zobrazovat nebude - je jich jen par
    if (params[:controller] == "users" && params[:action] == "new")
      return false
    end
    # pokud nejsou splneny podminky pro skryti, je lednicka zobrazena
    return true
  end

  def get_content_class
    # trida obsahu zavisi na tom, zda je zobrazena lednicka. Pokud ne, je zleva odsazen
    return show_fridge ? "span8" : "span8 offset2"
  end
end
