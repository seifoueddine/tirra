class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy,:edit_price]

  # GET /products
  # GET /products.json
  def index
    datatable_paginate([:product],['code;designation;name;price'])


  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find params[:id]
    pro_id = @product.id
    @stock = Stock.all
    stc = Stock.find_by product_id: pro_id
    if stc != nil
      stc.designation = @product.designation
      stc.code = @product.code
      stc.price = @product.price
      stc.save
    else
    @tests = Stock.new
    @tests.product_id = @product.id
    @tests.amount = 0
    @tests.designation = @product.designation
    @tests.code = @product.code
    @tests.price = @product.price
    @tests.pmp = 0
    @tests.save
end

  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    authorize! :read, @product
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.price = 0

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_price
    @product = Product.find(params[:id])
    pro_id = @product.id
    @stock = Stock.all
    stc = @stock.find_by product_id: pro_id
    str = params[:price]
    @product.save
    stc.price = str
    stc.save

  end


  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:code, :designation, :price,:family_id,:image)
    end
end
