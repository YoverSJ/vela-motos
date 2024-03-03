class MainController < ApplicationController

  def index

  end

  def about_us

  end

  def catalog
    @products = Product.all
  end

  def contact

  end

end
