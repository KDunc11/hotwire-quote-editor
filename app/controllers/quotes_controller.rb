# frozen_string_literal: true

class QuotesController < ApplicationController
  def index
    @quotes = current_company.quotes.ordered
  end

  def show
    quote
  end

  def new
    build_quote
  end

  def create
    build_quote

    if quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    quote
  end

  def update
    if quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def build_quote
    @quote ||= quote_scope.build
    @quote.attributes = quote_params
  end

  def quote
    @quote ||= quote_scope.find_by(oid: params[:id])
  end

  def quote_params
    return {} if params[:quote].blank?

    params.require(:quote).permit(:name)
  end

  def quote_scope
    current_company.quotes
  end
end
