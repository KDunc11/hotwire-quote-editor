class QuotesController < ApplicationController
  def index
    @quotes ||= quote_scope
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
      redirect_to quotes_path, notice: "Quote was successfully created."
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
    redirect_to quotes_path, notice: "Quote was successfully destroyed."
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
    return {} unless params[:quote].present?

    params.require(:quote).permit(:name)
  end

  def quote_scope
    Quote.all
  end
end
