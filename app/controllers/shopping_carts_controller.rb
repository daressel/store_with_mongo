class ShoppingCartsController < ApplicationController

  def show
    @shopping_cart = User.find(session[:user_id]).shopping_cart
    @products = []
    @shopping_cart.products.each do |product_id, count|
      @products.push(Product.find(product_id))
    end
  end

  def add_to_cart

    user = User.find(session[:user_id])
    shopping_cart = user.shopping_cart
    shopping_cart.products[params[:id]] = 1
    shopping_cart.full_price += params[:price].to_f
    shopping_cart.save
    respond_to do |format|
      format.json { render json: {"quantity": shopping_cart.products.count} }
    end
  end

  def remove_from_cart
    user = User.find(session[:user_id])
    shopping_cart = user.shopping_cart
    shopping_cart.products.except!(params[:id])
    shopping_cart.full_price -= params[:price].to_f
    shopping_cart.save
    respond_to do |format|
      format.json { render json: {"quantity": shopping_cart.products.count} }
    end
  end

  def clear_cart
    p params
  end

end
