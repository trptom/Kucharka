# coding:utf-8

module UsersHelper

  def index_get_row_class(user)
    if (is_admin(user))
      return "info"
    end

    return user.active ? "" : "error"
  end

  def index_get_action_button(user)
    if (is_admin(user) || is_current_user(user))
      if users_filter("block", :id => user.id)
        return button_to "Zablokovat", users_path, {:method => "get", :class => "btn disabled", :disabled => true}
      end
    end

    if !is_activated(user)
      if users_filter("activate", :id => user.id)
        return button_to "Aktivovat", { :controller => 'users', :action => 'activate', :id => "#{user.activation_token}", :redirect => "/users"}, {:method => "get", :class => "btn"}
      end
    else
      if user.active
        if users_filter("block", :id => user.id)
          return button_to "Zablokovat", { :controller => 'users', :action => 'block', :id => user.id}, {:method => "get", :class => "btn"}
        end
      else
        if users_filter("unblock", :id => user.id)
          return button_to "Odblokovat", { :controller => 'users', :action => 'unblock', :id => user.id}, {:method => "get", :class => "btn"}
        end
      end
    end

    return "Žádné"
  end
end
