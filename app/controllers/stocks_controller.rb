class StocksController < ApplicationController
  def index
    datatable_paginate([:stock],['code;designation;amount'])
    @stock = Stock.all

    end

  def destroy
    @sto = Stock.find(params[:id])
    @sto.destroy
    respond_to do |format|
      format.html { redirect_to stocks_path, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def alert_stock
@stock = Stock.all
  end
end
