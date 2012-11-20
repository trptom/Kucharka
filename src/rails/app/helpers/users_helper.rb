# coding:utf-8

module UsersHelper
  def can_edit(user)
    return (is_current_user(user) ||
      current_user.has_role?(:users, :edit) ||
      current_user.has_role?(:system, :administrator))
  end

  def can_list()
    return (current_user.has_role?(:users, :index) ||
      current_user.has_role?(:system, :administrator))
  end

  def render_edit_button(user, prefix, suffix)
    if can_edit(user)
      concat (prefix == nil) ? '' : prefix
      concat (link_to 'Editovat', edit_user_path(user))
      concat (suffix == nil) ? '' : suffix
    end
  end

  def render_list_button(prefix, suffix)
    if can_list()
      concat (prefix == nil) ? '' : prefix
      concat (link_to 'Jit na prohlíženi uživatelů', users_path)
      concat (suffix == nil) ? '' : suffix
    end
  end

  def render_destroy_button(user, prefix, suffix)
    if can_edit(user)
      concat (prefix == nil) ? '' : prefix
      concat (link_to 'Destroy', user, method: :delete, data: { confirm: 'Jste si jistý(á)?' })
      concat (suffix == nil) ? '' : suffix
    end
  end
end
