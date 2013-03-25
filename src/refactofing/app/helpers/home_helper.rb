module HomeHelper
  def get_recipes_by_search(p)
    if p[:search_query] == nil
      return Array.new
    end

    ret = Array.new

    ret.concat(Recipe.where("name LIKE ?", "%#{p[:search_query]}%").order(:name).all);
    ret.concat(Recipe.where("annotation LIKE ?", "%#{p[:search_query]}%").order(:name).all);
    ret.concat(Recipe.where("content LIKE ?", "%#{p[:search_query]}%").order(:name).all);

    return ret;
  end

  def get_articles_by_search(p)
    if p[:search_query] == nil
      return Array.new
    end

    ret = Array.new

    ret.concat(Article.where("title LIKE ?", "%#{p[:search_query]}%").order(:title).all);
    ret.concat(Article.where("annotation LIKE ?", "%#{p[:search_query]}%").order(:title).all);
    ret.concat(Article.where("content LIKE ?", "%#{p[:search_query]}%").order(:title).all);

    return ret;
  end
end
