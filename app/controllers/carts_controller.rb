class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :add_item, :remove_item, :clear]

  def show
    @cart = Cart.includes(cart_items: [:product]).find_by(user_id: params[:user_id])
    render json: @cart.to_json(include: { cart_items: { include: :product } })
  end

  def add_item
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    if cart_item.quantity
      cart_item.quantity += params[:quantity].to_i
    else
      cart_item.quantity = params[:quantity].to_i
    end
    if cart_item.save
      render json: @cart.to_json(include: { cart_items: { include: :product } })
    else
      render json: cart_item.errors, status: :unprocessable_entity
    end
  end

  def remove_item
    cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    if cart_item
      cart_item.destroy
      render json: @cart.to_json(include: { cart_items: { include: :product } })
    else
      render json: { error: 'Item not found in cart' }, status: :not_found
    end
  end

  def clear
    @cart.cart_items.destroy_all
    render json: @cart, include: ['cart_items.product']
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(user_id: params[:user_id])
  end
end
