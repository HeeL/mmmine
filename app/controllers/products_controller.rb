class ProductsController < ApplicationController
  
  before_filter :authenticate_user!, except: :index
  before_filter :show_sidebar, only: [:index, :live_feed, :top_stores]
  before_filter :find_product, only: [:show, :destroy, :buy, :follow, :share]

  SEARCH_KEYS = [:search, :desc, :order, :sub_category_id, :things_i_want]

  def index
    list_products(product_conditions, product_list_path(list_params))
  end

  def show
  end

  def live_feed
    products = Product.where(user_id: current_user.following_users.map(&:id))
    list_products(products, live_feed_path)
  end

  def top_stores
    @product_list_options = {
      classes: 'content row3 products_list',
      path: top_stores_path
    }
    user_ids = User.order('followed DESC').limit(10).map(&:id)
    @products = Product.unscoped.select('DISTINCT ON (user_id) *').where(user_id: user_ids)
    @products.sort!{|x,y| y.user.followed <=> x.user.followed}
  end

  def create
    @product = current_user.products.new(params[:product])
    if @product.valid? && params[:product_pictures].present?
      @product.save
      params[:product_pictures].each do |i, pic|
        @product.product_pictures.create(picture: pic)
      end
    end
  end

  def destroy
    authorize! :destroy, @product
    @product.destroy

    redirect_to live_feed_path
  end

  def buy
    @product.update_attributes(sold_to: current_user.id)
    PurchaseMailer.buyer(current_user, @product).deliver
    PurchaseMailer.seller(current_user, @product).deliver
  end

  def follow
    if @follow = current_user.following?(@product)
      current_user.stop_following(@product)
      @product.followed -= 1
    else
      current_user.follow(@product)
      @product.followed += 1
      add_comment
      Notification.add(
        { 
          from_user_id: current_user.id,
          to_user_id:   @product.user.id,
          item_id:      @product.id
        },
        :follow_product
      )
    end
    @product.save
  end

  def share
    if params[:users].present?
      username_list = params[:users].split(',')
      @users = username_list.map{|u| "@#{u}"}.join(', ')
      @product.update_attributes(shared: @users.split(',').count + @product.shared)
      params[:comment] = "#{@users}. #{params[:comment]}" 
      add_comment
      User.where(name: username_list).each do |user|
        Notification.add(
          { 
            from_user_id: current_user.id,
            to_user_id:   user.id,
            item_id:    @product.id
          },
          :share_product
        )
      end
    end
  end

  private

  def product_conditions
    product = Product
    if params[:sub_category_id]
      product = product.where(sub_category_id: params[:sub_category_id])
    end
    if params[:things_i_want]
      product = User.find(params[:things_i_want]).following_products
    end
    if params[:order] && ['followed'].include?(params[:order])
      product = product.unscoped.order("#{params[:order]} #{'DESC' if params[:desc]}");
    end
    if params[:search]
      fields = [
        '"products".title',
        '"products".size',
        '"products".price',
        '"products".description',
        '"sub_categories".title',
        '"categories".title'
      ]
      query = []
      words = params[:search]
      words.gsub!(/[^\sa-z0-9]/im, '')
      words.split(' ').each do |word|
        query << fields.join(" ILIKE '%#{word}%' OR ") + " ILIKE '%#{word}%'"
      end
      if query.present?
        log_query unless request.xhr?
        query = query.join(' OR ')
        product = product.unscoped.includes([:category, :sub_category]).where(query).order('"products".created_at desc')
      end
    end
    product
  end

  def list_products(products, path)
    @product_list_options = {
      classes: 'content row3 products_list',
      path: path
    }
    @products = get_product_list(products, @product_list_options)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def add_comment
    if params[:comment].present?
      @comment = current_user.comments.create(
        text: params[:comment],
        product: @product
      )
    end
  end

  def show_sidebar
    @right_section = true
  end

  def list_params
    keys = {}
    SEARCH_KEYS.each do |key|
      keys[key] = params[key]
    end
    keys
  end

  def log_query
    SearchLog.create(query: params[:search])
  end

end
