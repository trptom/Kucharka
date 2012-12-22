# coding:utf-8

module PermissionsHelper
  def user_has_permission(user, permission_self, permission_other)
    return (((permission_self == nil) || ((permission_self & user.self_ruleset) > 0)) &&
          ((permission_other == nil) || ((permission_other & user.others_ruleset) > 0)))
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
      condition = (current_user.id == condition)
    end
    if condition.kind_of? String
      condition =  (current_user.id == condition.to_i)
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
      return (p[:id] == nil && current_user != nil) || is_current_user(p[:id])
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
      return (p[:id] == nil && current_user != nil) || is_current_user(p[:id])
    end

    if action == "show"
      return has_permission_self_other(
          (current_user != nil && (p[:id] == nil || (p[:id].to_i == current_user.id))),
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
        action != "create")
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

    if action == "edit" || action == "update"
      return has_permission_self_other(entity.user_id, ROLE['recipes']['edit'])
    end

    if action == "new" || action == "create"
      return has_permission(ROLE['recipes']['create'], nil)
    end

    if action == "destroy"
      return has_permission_self_other(entity.user_id, ROLE['recipes']['delete'])
    end

    if action == "show"
      return has_permission_self_other(entity.user_id, ROLE['recipes']['show'])
    end

    # na index se dostanu vzdycky, jen se to tam trochu vyfiltruje

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

    return true;
  end

  def comments_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index")
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

    return true;
  end

  def ingrediences_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index")
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

    if action == "index"
      return has_permission_one(ROLE['ingrediences']['create_delete']) ||
          has_permission_one(ROLE['ingrediences']['edit'])
    end

    return true;
  end

  def ingredience_categories_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index")
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

    return true;
  end

  def recipe_categories_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      p = Hash.new
    end
    # pokud neni nastavena zadna DB entita, nactu ji podle id z parametru
    if (entity == nil &&
        action != "index")
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

    return true;
  end

  def marks_filter(action, p, entity)
    # aby to nechcipalo, pokud p nenastavim
    if (p == nil)
      return false;
    end

    if action == "create"
      return has_permission(ROLE['marks']['create'], nil)
    end

    if action == "show"
      return has_permission_both(ROLE['marks']['show'])
    end

    if action == "delete"
      return has_permission(ROLE['marks']['delete'], nil)
    end

    return true;
  end
end