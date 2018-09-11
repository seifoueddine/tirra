class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy,:add_produit]

  # GET /purchases
  # GET /purchases.json
  def index
    date = Date.today.strftime("%d/%m/%Y")

    if params[:start_date]
      if Date.parse(params[:end_date]) < Date.parse(params[:start_date])
        flash[:error] = 'Invalid dates'
      else
        session[:start_pub] = params[:start_date]
        session[:end_pub] = params[:end_date]
      end
    end
    session[:start_pub] ||= date
    session[:end_pub] ||= date

    datatable_paginate([:purchase],['date;total_price;contact_name',['purchases',"purchases.date >='#{Date.parse(session[:start_pub])}' and purchases.date <='#{Date.parse(session[:end_pub])}'"]])
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    @cont_sel = @purchase.product_purchases

    @acha_pros = @purchase.product_purchases.order(:quantity)

    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf {render pdf: "purchase",
               template: "purchases/show.pdf.erb",
               locals: {:purchase => @purchase}}

      format.xlsx {render xlsx: "purchase",
                          template: "purchases/show.xlsx.axlsx",
                          locals: {:purchase => @purchase}}
      end


  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.total_price = 0;
    @purchase.contact_name = @purchase.contact.raison

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end



  def add_produit
    @pro = ProductPurchase.new
    @pro.purchase = @purchase

    @pro.product = Product.find(params[:product_id])
    @test = @pro.product
    r = params[:price]
    @pro.quantity = params[:quantity]
    @pro.price = r
    x = @pro.price
    a = @purchase.total_price
    v = @pro.quantity
    if a == nil
      a=0
      f = a + x * v
    else
      f = a + x * v
    end
    @purchase.total_price = f
    @test.save
    @purchase.save

    @pross = Product.find(params[:product_id])
    pro_id = @pross.id

    str = ProductPurchase.where product_id: pro_id
    b = str.ids
    c = b.length - 1

    total = 0
    pri = 0
    qunt = 0

    for i in 0..(c)
      pri = pri + str[i].price
      qunt = qunt + str[i].quantity
       total = total + ( str[i].price * str[i].quantity)
    end


tot = 0
    tot = tot + (@pro.quantity * @pro.price)
    pmp = (total + tot) / (qunt + @pro.quantity)

    @stock = Stock.all
    stc = Stock.find_by product_id: pro_id
    @pross.amount = params[:quantity]
    totale = 0
    totale = stc.amount
    stc.amount = totale +  @pross.amount

      stc.product_id = pro_id
      stc.amount = stc.amount
      stc.designation = @pross.designation
      stc.code = @pross.code
      stc.price = @pross.price
      stc.pmp = pmp
      stc.save

      if @pro.save
      flash[:notice] = 'Achat enregistré avec succes.'
      redirect_to :action => :show, :id => params[:id]
    else
      flash[:error] = "Une erreur s'est produite."
      redirect_to :action => :show, :id => params[:id]
    end
  end

  def delete_produit
    @pro = ProductPurchase.find(params[:product_id])

    partial = @pro.quantity * @pro.price
    @test = Purchase.find(params[:id])
    total = @test.total_price
    @test.total_price = total -  partial
    @test.save
    @pro.destroy
    respond_to do |format|
      format.html { redirect_to purchase_url(params[:id]), notice: 'purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:date, :total_price ,:contact_id,:document)
    end
end
