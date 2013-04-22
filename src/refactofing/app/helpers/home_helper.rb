# coding:utf-8

module HomeHelper

  def get_recipes_by_search(p)
    if p[:search_query] == nil || p[:search_query] == ""
      return "Neplatný výraz pro vyhledávání."
    end

    ret = Array.new

    ret.concat(Recipe.where("name LIKE ?", "%#{p[:search_query]}%").order(:name).all);
    ret.concat(Recipe.where("annotation LIKE ?", "%#{p[:search_query]}%").order(:name).all);
    ret.concat(Recipe.where("content LIKE ?", "%#{p[:search_query]}%").order(:name).all);

    ret = ret.uniq

    if ret.length > MAX_SEARCH_RESULTS
      return "Nalezeno příliš mnoho výsledků. Prosím upřesněte hledaný výraz."
    end

    return ret;
  end

  def get_articles_by_search(p)
    if p[:search_query] == nil || p[:search_query] == ""
      return "Neplatný výraz pro vyhledávání."
    end

    ret = Array.new

    ret.concat(Article.where("title LIKE ?", "%#{p[:search_query]}%").order(:title).all);
    ret.concat(Article.where("annotation LIKE ?", "%#{p[:search_query]}%").order(:title).all);
    ret.concat(Article.where("content LIKE ?", "%#{p[:search_query]}%").order(:title).all);

    ret = ret.uniq

    if ret.length > MAX_SEARCH_RESULTS
      return "Nalezeno příliš mnoho výsledků. Prosím upřesněte hledaný výraz."
    end

    return ret;
  end
end
