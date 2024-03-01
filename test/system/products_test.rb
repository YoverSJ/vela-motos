require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    fill_in "Code", with: @product.code
    fill_in "Color", with: @product.color
    fill_in "Description", with: @product.description
    fill_in "Discount", with: @product.discount
    fill_in "Imagen", with: @product.imagen
    fill_in "Name", with: @product.name
    fill_in "Price", with: @product.price
    fill_in "Stock", with: @product.stock
    fill_in "Total price", with: @product.total_price
    fill_in "Warranty", with: @product.warranty
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Code", with: @product.code
    fill_in "Color", with: @product.color
    fill_in "Description", with: @product.description
    fill_in "Discount", with: @product.discount
    fill_in "Imagen", with: @product.imagen
    fill_in "Name", with: @product.name
    fill_in "Price", with: @product.price
    fill_in "Stock", with: @product.stock
    fill_in "Total price", with: @product.total_price
    fill_in "Warranty", with: @product.warranty
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
