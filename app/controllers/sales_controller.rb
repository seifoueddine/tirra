class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy, :add_produit]

  # GET /sales
  # GET /sales.json
  def index
    date = Date.today.strftime("%d/%m/%Y")

    if params[:start_date]
      if Date.parse(params[:end_date]) < Date.parse(params[:start_date])
        flash[:alert] = 'Invalid dates'
      else
        session[:start_pub] = params[:start_date]
        session[:end_pub] = params[:end_date]
      end
    end
    session[:start_pub] ||= date
    session[:end_pub] ||= date

    datatable_paginate([:sale],['date;total_price;contact_name;contact_id',['sales',"sales.date >='#{Date.parse(session[:start_pub])}' and sales.date <='#{Date.parse(session[:end_pub])}'"]])


  end

  # GET /sales/1
  # GET /sales/1.json
  def show

    @cont_sel = @sale.product_sales
    @cont_bon = @sale.product_sales.where.not(bonus: nil)

    @ven_pros = @sale.product_sales.where(bonus: nil).order(:quantity)

    @sale = Sale.find(params[:id])
    d = @sale.id

    @sar = ProductSale.where sale_id: d
    b = @sar.ids
    c = b.length - 1
    j = 0
    @sac = Array.new
    for i in 0..(c)
      if @sar[i].bonus != nil
        @sac[j] = @sar[i].bonus
        j= j+1
      end
    end

    respond_to do |format|
      format.html
      format.pdf {render pdf: "sale",
               template: "sales/show.pdf.erb",
               locals: {:sale => @sale}}

      format.xlsx {render xlsx: "sale",
                 template: "sales/show.xlsx.axlsx",
                 locals: {:sale => @sale}}
        end



  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale.contact_name = @sale.contact.raison
    #@sale.products << Product.find(params[:product_id])
@sale.total_price = 0;
    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

def add_bonus
   @pro = ProductSale.new
   @pros = Sale.find(params[:id])
   @pro_bon = ProductSale.find_by sale_id: @pros
   if @pro_bon != nil
     @pross = Product.find(params[:product_id])

     @pro.price = @pross.price
     @pro.product_id = @pross.id
   @pro.sale_id = @pros.id
   @pro.quantity = params[:quantity]
   @pro.bonus = @pross.designation
if @pros.bonus == nil || @pros.bonus == 0
  @pros.bonus = 0
     tot = @pros.bonus
@pros.bonus = tot + 1
  @pros.authorizer = params[:authorizer]
end
  pro_id = @pross.id
  @stock = Stock.all

  stc = Stock.find_by product_id: pro_id
  total = stc.amount
  stc.amount = total - @pro.quantity
  stc.save
     @pros.save
     @pro.save
  if stc.save
    flash[:notice] = 'Bonus enregistré avec succes.'
    redirect_to :action => :show, :id => params[:id]
  else
    flash[:error] = "Une erreur s'est produite."
    redirect_to :action => :show, :id => params[:id]
  end
   else
     flash[:notice] = 'you have to sale some product first'
     redirect_to :action => :show, :id => params[:id]
     end
end



  def del_bonus
    @pross = Sale.find(params[:id])
    tot = @pross.bonus
    @pross.bonus = tot - 1
    bon_id = @pross.id
@pross.save
    bons = ProductSale.where sale_id: bon_id
    b = bons.ids
    c = b.length - 1
    for i in 0..(c)
      if bons[i].bonus != nil
        @temp = bons[i]
        end
    end

    if @temp.destroy
      flash[:notice] = 'Bonus destroyed succefuly.'
      redirect_to :action => :show, :id => params[:id]
    else
      flash[:error] = "Une erreur s'est produite."
      redirect_to :action => :show, :id => params[:id]
    end
  end

  def add_produit
    @pro = ProductSale.new
    @pro.sale = @sale
    @pro.product = Product.find(params[:product_id])
    k = @sale.id
    @sal = @pro.product
    rem = Stock.find_by product_id: @sal.id
    r = rem.price
    @pro.quantity = params[:quantity]
    @pro.remise = params[:remise]
    @pro.price = params[:price]
if @pro.remise != nil
    x = @pro.remise

else
  x = @pro.price
  @pro.remise = 0
  end
    v = @pro.quantity
    a = @sale.total_price
    if a == nil || a == 0
      a=0
      f = a + x * v
    else
      f = a + x * v
    end
    @sale.total_price = f
    @sale.save

    @pross = Product.find(params[:product_id])
    pro_id = @pross.id
    @stock = Stock.all

    stc = Stock.find_by product_id: pro_id
    @pross.amount = params[:quantity]

    @sac = stc.amount

if @pross.amount <= stc.amount
    total = stc.amount
    stc.amount = total - @pross.amount
    stc.save

    if @pro.save
      flash[:notice] = 'Vendre enregistré avec succes.'
      redirect_to :action => :show, :id => params[:id]
    else
      flash[:error] = "Une erreur s'est produite."
      redirect_to :action => :show, :id => params[:id]
    end

else
  flash[:notice] = "there is not enought amount in the stock"
  redirect_to :action => :show, :id => params[:id]
end
  end

  def delete_produit
     @pro = ProductSale.find(params[:product_id])

     partial = @pro.quantity * @pro.price
     @sal = Sale.find(params[:id])
     total = @sal.total_price
     @sal.total_price = total -  partial
     @sal.save
     @pro.destroy
    respond_to do |format|
      format.html { redirect_to sale_url(params[:id]), notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:date, :total_price,:contact_id,:customer_id)
    end

end
