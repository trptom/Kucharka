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
    @ret = Array.new

    for a in 1..count
      @tmp = SecureRandom.random_number(@id.id) + 1;
      @ret << Recipe.find(@tmp)
    end

    return @ret
  end
end