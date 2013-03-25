# coding:utf-8

class UsersController < ApplicationController
  before_filter :user_rights_filter
  
  # GET /users
  # GET /users.json
  def index
    filter = get_filter("username")
    if (filter != nil)
      @users = User.where("username like ?", "%" + filter +"%").all
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id] ? params[:id] : current_user.id)

    @users = User.all
    @links_title = "Další uživatelé"
    @links = []
    for user in @users
      if (user != @user)
        @links.push([user.username, user_path(user)])
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id] ? params[:id] : current_user.id)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    if @user.save
      UserMailer.activation_needed_email(@user).deliver
      redirect_to  "/home/success", notice: 'Na email, zadaný při registraci byl zaslán kontrolní mail. Účet aktivujete kliknutím na odkaz uvnitř mailu.'
    else
      @errors = @user.errors
      render action: "new"
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      @errors = @user.errors
      render action: "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      UserMailer.activation_success_email(@user).deliver
      # presmeruju na seznam uzivatelu, pokud neni zdrojem aktivace email
      redirect_to(params[:src] == "email" ? "/home/success" : "/users", :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  def recipes
    @user = User.find(params[:id] ? params[:id] : current_user.id)
    @recipes = @user.recipes;
    @commented = @user.comments.where("recipe_id IS NOT NULL")
    @marked = @user.marks
    @splitted = Array.new
    @commented.each do |item|
      if !@splitted.include?(item.recipe)
        @splitted << item.recipe
      end
    end
    @marked.each do |item|
      if !@splitted.include?(item.recipe)
        @splitted << item.recipe
      end
    end
  end

  def articles
    @user = User.find(params[:id] ? params[:id] : current_user.id)
    @articles = @user.articles;
    @commented_all = @user.comments.where("article_id IS NOT NULL")
    @commented = Array.new
    @commented_all.each do |item|
      if !@commented.include?(item.article)
        @commented << item.article
      end
    end
  end

  def block
    @user = User.find(params[:id])
    state = NIL;
    if (!is_admin(@user) && !is_current_user(@user))
      @user.active = false
      if !@user.save
        state = "Blokování uživatele selhalo!"
      end
    else
      state = "Nelze blokovat administrátorský účet ani aktuálního uživatele!"
    end

    redirect_to users_path, notice: state
  end

  def unblock
    @user = User.find(params[:id])
    state = NIL;
    # jen pro jistotu. Admin by nemel byt nikdy zablokovany a blokovany uzivatel
    # by se neprihlasil (nebyl by current).
    if (!is_admin(@user) && !is_current_user(@user))
      @user.active = true
      if !@user.save
        state = "Odblokování uživatele selhalo!"
      end
    else
      state = "Nelze odblokovat administrátorský účet ani aktuálního uživatele!"
    end

    redirect_to users_path, notice: state
  end
end
