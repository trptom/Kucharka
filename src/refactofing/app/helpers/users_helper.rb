# coding:utf-8

module UsersHelper
  def index_get_row_class(user)
    if (is_admin(user))
      return "info"
    end

    return user.active ? "" : "error"
  end

  def get_action_buttons(user)
    ret = Array.new;

    #states
    tmp = get_change_state_button(user);
    if tmp != nil
      ret << tmp
    end

    #edit
    tmp = get_edit_button(user);
    if tmp != nil
      ret << tmp
    end

    #edit
    tmp = get_destroy_button(user);
    if tmp != nil
      ret << tmp
    end

    return ret;
  end

  def get_change_state_button(user)
    if (is_admin(user) || is_current_user(user))
      if users_filter("block", :id => user.id)
        return link_to "Zablokovat", users_path, {:method => "get", :class => "btn"}
      end
    end

    if !is_activated(user)
      if users_filter("activate", :id => user.id)
        return link_to "Aktivovat", { :controller => 'users', :action => 'activate', :id => "#{user.activation_token}", :redirect => "/users"}, {:method => "get", :class => "btn"}
      end
    else
      if user.active
        if users_filter("block", :id => user.id)
          return link_to "Zablokovat", { :controller => 'users', :action => 'block', :id => user.id}, {:method => "get", :class => "btn"}
        end
      else
        if users_filter("unblock", :id => user.id)
          return link_to "Odblokovat", { :controller => 'users', :action => 'unblock', :id => user.id}, {:method => "get", :class => "btn"}
        end
      end
    end

    return nil
  end

  def get_edit_button(user)
    if users_filter("edit", :id => user.id)
      return link_to "Editovat", { :controller => 'users', :action => 'edit', :id => user.id}, {:method => "get", :class => "btn"}
    else
      return nil
    end
  end

  def get_destroy_button(user)
    if users_filter("destroy", :id => user.id)
      return nil; # zatim neni implementovano
#      return link_to "Smazat", { :controller => 'users', :action => 'destroy', :id => user.id}, {:method => "get", :class => "btn" }
    else
      return nil
    end
  end

  def edit_get_rule_checkbox(user, rulevalue, type)
    checked = false;
    if type == 0
      checked = user_has_permission(user, rulevalue, nil)
    end
    if type == 1
      checked = user_has_permission(user, nil, rulevalue)
    end
    if type == 2
      checked = user_has_permission(user, rulevalue, rulevalue)
    end

    return check_box("xxx", nil, {:checked => checked, :onchange => "UserRights.update(this.checked, " + (rulevalue.to_s) +", " + (type.to_s) + ")"})
  end
end
