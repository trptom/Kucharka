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

  def show_left_panel
    # podminky, kdy se leve menu zobrazovat nebude - je jich jen par
    if (params[:controller] == "users" && params[:action] == "new")
      return false
    end
    # pokud nejsou splneny podminky pro skryti, je leve menu zobrazeno
    return true
  end

  def get_content_class
    # trida obsahu zavisi na tom, zda je zobrazeno leve menu. Pokud ne, je zleva odsazen
    return show_left_panel ? "span8" : "span8 offset2"
  end

  def render_self_than_global(template)
#    return exists?(params[:controller], "links")
    return render template rescue render ("layouts/" + template)
  end
end
