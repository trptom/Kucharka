# coding:utf-8

module PermissionsHelper
  def user_has_permission(user, permission_self, permission_other)
    return (((permission_self == nil) || ((user) && ((permission_self & user.self_ruleset) > 0))) &&
          ((permission_other == nil) || ((user) && ((permission_other & user.others_ruleset) > 0))))
  end

  def has_permission(permission_self, permission_other)
    if current_user == nil
      return false
    end
    return user_has_permission(current_user, permission_self, permission_other)
  end

  def has_permission_both(permission)
    return has_permission(permission, permission)
  end

  def has_permission_one(permission)
    return has_permission(nil, permission) ||
      has_permission(permission, nil)
  end

  # na zaklade podminky kontroluje bud ze self rulesetu (pokud je true) nebo other (false)
  def has_permission_self_other(condition, permission)
    if condition == nil
      return false
    end
    if condition.kind_of? Numeric
      if current_user
        condition = (current_user.id == condition)
      else
        return false
      end
    end
    if condition.kind_of? String
      if current_user
        condition =  (current_user.id == condition.to_i)
      else
        return false
      end
    end

    return has_permission_self_other_diff(condition, permission, permission)
  end

  # na zaklade podminky kontroluje bud self opravneni (pokud je true) nebo other (false)
  def has_permission_self_other_diff(condition, permission_self, permission_other)
    if condition == nil
      return false
    end
    if condition.kind_of? Numeric
      condition = (current_user.id == condition)
    end
    if condition.kind_of? String
      condition =  (current_user.id == condition.to_i)
    end

    if condition
      return has_permission(permission_self, nil)
    else
      return has_permission(nil, permission_other)
    end
  end

  def user_rights_filter
    has_access = true;

    if params[:controller] == "users"
      has_access = users_filter(params[:action], params)
    end

    if params[:controller] == "recipes"
      has_access = recipes_filter(params[:action], params, nil)
    end

    if params[:controller] == "articles"
      has_access = articles_filter(params[:action], params, nil)
    end

    if params[:controller] == "comments"
      has_access = comments_filter(params[:action], params, nil)
    end

    if params[:controller] == "marks"
      has_access = marks_filter(params[:action], params, nil)
    end

    if params[:controller] == "ingrediences"
      has_access = ingrediences_filter(params[:action], params, nil)
    end

    if params[:controller] == "recipeCategories"
      has_access = recipe_categories_filter(params[:action], params, nil)
    end

    if params[:controller] == "ingredienceCategories"
      has_access = ingredience_categories_filter(params[:action], params, nil)
    end

    if (!has_access)
      redirect_to "/home/error", notice: "Stránka neexistuje, nebo byl přístup na požadovanou stránku odepřen!"
    end
  end

  def users_filter(action, p)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end

    if action == "articles"
      # Kontroluje, zda jde o pozadavek pro aktualniho uzivatele.
      # Pokud neni uvedeno id, zobrazuje to aktualniho uzivatele.
      # Teprv pokud neni ani ten, vraci false.
      return (p[:id] == nil && current_user) || is_current_user(p[:id])
    end

    if action == "edit" || action == "update"
      # musi mit edit podle toho, zda upravuje sebe nebo ciziho
      return has_permission_self_other(p[:id], ROLE['users']['edit'])
    end

    if action == "create" || action == "new"
      # musi mit vytvareni a vzdycky vytvari ciziho
      return has_permission(nil, ROLE['users']['create'])
    end

    if action == "index"
      return has_permission_both(ROLE['users']['index'])
    end

    if action == "recipes"
      # Kontroluje, zda jde o pozadavek pro aktualniho uzivatele.
      # Pokud neni uvedeno id, zobrazuje to aktualniho uzivatele.
      # Teprv pokud neni ani ten, vraci false.
      return (p[:id] == nil && current_user) || is_current_user(p[:id])
    end

    if action == "show"
      return has_permission_self_other(
          (current_user && (p[:id] == nil || (p[:id].to_i == current_user.id))),
          ROLE['users']['show'])
    end

    if action == "destroy"
      # musi mit delete podle toho, zda upravuje sebe nebo ciziho. NEjde smazat admina a sebe sama.
      return !is_admin(p[:id]) &&
        !is_current_user(p[:id]) &&
        has_permission_self_other(p[:id], ROLE['users']['delete'])
    end

    if action == "block"
      return false;
      # musi mit block na ciziho, nesmi blokovat sebe nebo admina
      return (p[:id] != nil &&
          !is_admin(p[:id]) &&
          !is_current_user(p[:id]) &&
          has_permission(nil, ROLE['users']['block']))
    end

    if action == "unblock"
      # musi mit unblock na ciziho, nesmi odblokovat sebe nebo admina
      return (p[:id] != nil &&
          !is_admin(p[:id]) &&
          !is_current_user(p[:id]) &&
          has_permission(nil, ROLE['users']['unblock']))
    end

    # activate je dostupne vzdy.

    return true;
  end

  def recipes_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index" &&
        action != "new" &&
        action != "create" &&
        action != "fridge" &&
        action != "filter" &&
        action != "newest" &&
        action != "show")
      # musim mit id
      if (p[:id] == nil)
        return false
      else
        entity = Recipe.find(p[:id])
      end
      # zadna entita s danym id neexistuje
      if entity == nil
        return false;
      end
    end

    if action == "edit" || action == "update" ||
        action == "add_subrecipe" || action == "add_connected_article" ||
        action == "remove_subrecipe" || action == "remove_connected_article"
      return has_permission_self_other(entity.user_id, ROLE['recipes']['edit'])
    end

    if action == "new" || action == "create"
      return has_permission(ROLE['recipes']['create'], nil)
    end

    if action == "destroy"
      return has_permission_self_other(entity.user_id, ROLE['recipes']['delete'])
    end

    # na lednicku a filtr se dostanu vzdycky, jen se to tam trochu vyfiltruje
    # na index se dostanu vzdycky, jen se to tam trochu vyfiltruje
    # na show se dostanou vzdycky

    return true;
  end

  def articles_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index" &&
        action != "show" &&
        action != "create" &&
        action != "new")
      # musim mit id
      if (p[:id] == nil)
        return false
      else
        entity = Article.find(p[:id])
      end
      # zadna entita s danym id neexistuje
      if entity == nil
        return false;
      end
    end

    if action == "edit" || action == "update"
      return has_permission_self_other(entity.user_id, ROLE['articles']['edit'])
    end

    if action == "new" || action == "create"
      return has_permission(ROLE['articles']['create'], nil)
    end

    if action == "destroy"
      return has_permission_self_other(entity.user_id, ROLE['articles']['delete'])
    end

    # na index se dostanu vzdycky, jen se to tam trochu vyfiltruje
    # na show se dostanou vzdycky

    return true;
  end

  def comments_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "create")
      # musim mit id
      if (p[:id] == nil)
        return false
      else
        entity = Comment.find(p[:id])
      end
      # zadna entita s danym id neexistuje
      if entity == nil
        return false;
      end
    end

    if action == "create"
      return has_permission(ROLE['comments']['create'], nil)
    end

    if action == "update"
      return has_permission_self_other(entity.user_id, ROLE['comments']['update'])
    end

    if action == "destroy"
      return has_permission_self_other(entity.user_id, ROLE['comments']['delete'])
    end

    return true;
  end

  def ingrediences_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index" &&
        action != "create" &&
        action != "new" &&
        action != "new_request" &&
        action != "plain_list")
      # musim mit id
      if (p[:id] == nil)
        return false
      else
        entity = Ingredience.find(p[:id])
      end
      # zadna entita s danym id neexistuje
      if entity == nil
        return false;
      end
    end

    # jen pokud muze delat nejakou akci
    if action == "index"
      return has_permission_one(ROLE['ingrediences']['create_delete']) ||
          has_permission_one(ROLE['ingrediences']['edit'])
    end

    if action == "create" || action == "new"
      return has_permission(ROLE['ingrediences']['create_delete'], nil)
    end

    if action == "edit" || action == "update"
      return has_permission_self_other(entity.user_id, ROLE['ingrediences']['edit']);
    end

    if action == "destroy"
      return has_permission_self_other(entity.user_id, ROLE['ingrediences']['create_delete']);
    end

    if action == "new_request"
      return (true && current_user) # aby to vzdycky vracelo boolean
    end

    # show je dostupne vzdy, plain_list taky

    return true;
  end

  def ingredience_categories_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index" &&
        action != "create" &&
        action != "new")
      # musim mit id
      if (p[:id] == nil)
        return false
      else
        entity = IngredienceCategory.find(p[:id])
      end
      # zadna entita s danym id neexistuje
      if entity == nil
        return false;
      end
    end

    if action == "index"
      return has_permission_one(ROLE['ingredienceCategories']['create_delete']) ||
          has_permission_one(ROLE['ingredienceCategories']['edit'])
    end

    if action == "create" || action == "new"
      return has_permission(ROLE['ingredienceCategories']['create_delete'], nil)
    end

    if action == "edit" || action == "update"
      return has_permission_self_other(entity.user_id, ROLE['ingredienceCategories']['edit']);
    end

    if action == "destroy"
      return has_permission_self_other(entity.user_id, ROLE['ingredienceCategories']['create_delete']);
    end

    return true;
  end

  def recipe_categories_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index" &&
        action != "create" &&
        action != "new")
      # musim mit id
      if (p[:id] == nil)
        return false
      else
        entity = RecipeCategory.find(p[:id])
      end
      # zadna entita s danym id neexistuje
      if entity == nil
        return false;
      end
    end

    if action == "index"
      return has_permission_one(ROLE['recipeCategories']['create_delete']) ||
          has_permission_one(ROLE['recipeCategories']['edit'])
    end

    if action == "create" || action == "new"
      return has_permission(ROLE['recipeCategories']['create_delete'], nil)
    end

    if action == "edit" || action == "update"
      return has_permission_self_other(entity.user_id, ROLE['recipeCategories']['edit']);
    end

    if action == "destroy"
      return has_permission_self_other(entity.user_id, ROLE['recipeCategories']['create_delete']);
    end

    return true;
  end

  def marks_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end

    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index" &&
        action != "create" &&
        action != "show")
      # musim mit id
      if (p[:id] == nil)
        return false
      else
        entity = RecipeCategory.find(p[:id])
      end
      # zadna entita s danym id neexistuje
      if entity == nil
        return false;
      end
    end

    if action == "index"
      return has_permission_both(ROLE['marks']['index'])
    end
    
    if action == "create"
      return has_permission(ROLE['marks']['create'], nil)
    end

    if action == "show"
      return has_permission_both(ROLE['marks']['show'])
    end

    if action == "delete"
      return has_permission_self_other(entity.user_id, ROLE['marks']['delete'])
    end

    return true;
  end
end