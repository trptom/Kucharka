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
end