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

  def get_recipe_koef_for_fridge(recipe, p)
    koef = 0.0;
    sum = 0.0;
    # pokud nemam u receptu zadne ingredience, vrati se mi s nejnizsim moznym
    # vysledkem tak, aby byl zahrnut do vysledku, ale az na posledni pozici
    if recipe.ingredienceRecipeConnectors.length == 0
      return MIN_KOEF_FOR_FRIDGE_RESULT
    end
    # pokud ingredience mam, pocitam
    for recipe_ingredience in recipe.ingredienceRecipeConnectors
      sum += recipe_ingredience.importance
      for ingredience in p
        if (ingredience[:id] == recipe_ingredience.ingredience_id)
          koef += [1, ingredience[:quantity] ? (ingredience[:quantity]/recipe_ingredience.quantity) : 1].min * recipe_ingredience.importance
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
    @ret = Recipe.find(:all).shuffle

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


    if p[:ingrediences]
      for str in p[:ingrediences].each
        tmp = str.split("|");
        parsedP << { :id => tmp[0].to_i, :quantity => tmp[1] ? tmp[1].to_f : nil }
        if (inStr != "")
          inStr += ","
        end
        inStr += tmp[0] # tohle je string, tak abych to nemusel znova prevedet, neberu z parsedP
      end
    end

    # TODO - yatim neimplementuju dostupnost ingredienci
    #ingrediences = Ingredience.where("id IN (" + inStr + ")").all
    #concat("id IN (" + inStr + ")")

    # pocitani koeficienu
    list = Array.new
    for recipe in recipes
      koef = get_recipe_koef_for_fridge(recipe, parsedP)
      if (koef >= MIN_KOEF_FOR_FRIDGE_RESULT)
        list << { :recipe => recipe, :koef => koef}
      end
    end

    #razeni
    ret = Array.new
    badges = Hash.new
    while list.length > 0
      max_item = nil
      for item in list
        if max_item == nil || item[:koef] > max_item[:koef]
          max_item = item
        end
      end
      badges[max_item[:recipe].id] = Hash.new
      if max_item[:koef] > 0.9
        badges[max_item[:recipe].id]['class'] = "badge-success"
        badges[max_item[:recipe].id]['title'] = "doporučujeme"
      else if max_item[:koef] > 0.8
        badges[max_item[:recipe].id]['class'] = nil
        badges[max_item[:recipe].id]['title'] = "možná uvaříte"
      else if max_item[:koef] > 0.6
        badges[max_item[:recipe].id]['class'] = "badge-waring"
        badges[max_item[:recipe].id]['title'] = "s drobným nákupem"
      else
        badges[max_item[:recipe].id]['class'] = "badge-important"
        badges[max_item[:recipe].id]['title'] = "něco vám chybí"
      end end end
      ret << max_item[:recipe]
      list.delete(max_item)
    end

    return { :recipes => ret, :badges => badges }
  end
end