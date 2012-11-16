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
end
