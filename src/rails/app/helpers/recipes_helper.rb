# coding:utf-8

module RecipesHelper
  def get_level_class(level)
    if level == 0
      
    end
  end

  def get_mark(recipe)
    sum = 0
    count = 0
    recipe.marks.each do |mark|
      sum += mark.value;
      count += 1;
    end
    return count > 0 ? (sum/count).round(1) : nil;
  end

  def get_mark_str(recipe)
    mark = get_mark(recipe);
    return mark != nil ? mark.to_s : "žádné";
  end

  def get_ingrediences_ary_from_params(recipe_id)
    ret = Array.new
    if params[:ingrediences] != nil
      for ingredience in params[:ingrediences]
        tmp = ingredience.split("|");
        
        #najdu existujici vazbu pro recept x ingredience (pokud uz recept existoval)
        if recipe_id != nil
          irc = IngredienceRecipeConnector.where(:recipe_id => recipe_id).where(:ingredience_id => tmp[0].to_i).first
          irc.update_attribute(:quantity, tmp[1].to_f)
          irc.update_attribute(:importance, tmp[1].to_i)
        end
        # a pokud jsem vazbu nenasel, vytvarim novou (je to tadz, aby v DB nehnily stary zaznamy)
        if irc == nil
          irc = IngredienceRecipeConnector.new
          #nasetuju potrebne promenne
          irc.ingredience_id = tmp[0].to_i
          irc.quantity = tmp[1].to_f
          irc.importance = tmp[2].to_i
        end

        #pridam do vystupu
        ret << irc
      end
    end
    return ret
  end

  def get_recipe_koef_for_fridge(recipe, p, ingrediences)
    koef = 0.0;
    sum = 0.0;
    for recipe_ingredience in recipe.ingredienceRecipeConnectors
      sum += recipe_ingredience.importance
      for ingredience in p
        if (ingredience[:id] == recipe_ingredience.ingredience_id)
          koef += [1, ingredience[:quantity]/recipe_ingredience.quantity].min * recipe_ingredience.importance
        end
      end
    end
    return koef / sum;
  end

  #############
  # DB FILTRY #
  #############

  def get_recipes_by_keyphrase(phrase)

  end

  # pokud je count null, vraci vsechny, jinak omezeny pocet
  def get_recipes_sorted_by_date(count)
    return count == nil ?
        Recipe.order("created_at DESC").all :
        Recipe.order("created_at DESC").limit(count).all
  end

  # date je string pro porovnavani pomoci like
  def get_recipes_by_date(date, count)
    return count == nil ?
        Recipe.where("created_at LIKE "+date).all :
        Recipe.where("created_at LIKE "+date).limit(count).all
  end

  def get_recipes_by_random(count)
    @id = Recipe.last
    @ret = Recipe.find(:all, :order => 'rand()')

    return @ret
  end

  def get_recipes_by_mark(count)
    @id = Recipe.last
    @ret = Recipe.all(
      :select => "
        recipes.*,
        AVG(marks.value) as avg_value,
        MIN(marks.value) as min_value,
        MAX(marks.value) as max_value",
      :joins => :marks,
      :group => 'recipes.id'
    )

    return @ret
  end

  def get_recipes_by_filter(filter)
    if (filter == nil)
      return Recipe.order(:name).all
    end

    ret = Recipe.order(:name);

    if (filter[:text] && filter[:text] != "")
      tmp = "(name like '%#{filter[:text]}%')"
      if filter[:text_type] == "1"
        tmp += "OR(annotation LIKE \"%" + filter[:text] + "%\")"
        tmp += "OR(content LIKE \"%" + filter[:text] + "%\")"
      end
      ret = ret.where(tmp)
    end

    if (filter[:level] && filter[:level] != "")
      ret = ret.where("level = " + filter[:level])
    end

    if (filter[:time_min] && filter[:time_min] != "")
      ret = ret.where("estimated_time >= " + filter[:time_min])
    end

    if (filter[:time_max] && filter[:time_max] != "")
      ret = ret.where("estimated_time <= " + filter[:time_max])
    end

    return ret.all
  end

  def get_recipes_by_fridge(p)
    if (p == nil || p[:ingrediences] == nil || !(p[:ingrediences].length > 0))
      return nil
    end

    recipes = Recipe.all;
    parsedP = Array.new
    inStr = "" # string pro WHERE ? IN (.....)


    for str in p[:ingrediences].each
      tmp = str.split("|");
      parsedP << { :id => tmp[0].to_i, :quantity => tmp[1].to_f }
      if (inStr != "")
        inStr += ","
      end
      inStr += tmp[0] # tohle je string, tak abych to nemusel znova prevedet, neberu z parsedP
    end

    # TODO - yatim neimplementuju dostupnost ingredienci
    #ingrediences = Ingredience.where("id IN (" + inStr + ")").all
    #concat("id IN (" + inStr + ")")

    # pocitani koeficienu
    list = Array.new
    for recipe in recipes
      koef = get_recipe_koef_for_fridge(recipe, parsedP, nil)
      if (koef >= 0.5)
        list << { :recipe => recipe, :koef => koef}
      end
    end

    #razeni
    ret = Array.new
    while list.length > 0
      max_item = nil
      for item in list
        if max_item == nil || item[:koef] > max_item[:koef]
          max_item = item
        end
      end
      ret << max_item[:recipe]
      list.delete(max_item)
    end

    return ret
  end
end