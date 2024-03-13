require "application_system_test_case"

class AccessoriesTest < ApplicationSystemTestCase
  setup do
    @accessory = accessories(:one)
  end

  test "visiting the index" do
    visit accessories_url
    assert_selector "h1", text: "Accessories"
  end

  test "should create accessory" do
    visit accessories_url
    click_on "New accessory"

    fill_in "Category", with: @accessory.category
    fill_in "Code", with: @accessory.code
    fill_in "Color", with: @accessory.color
    fill_in "Description", with: @accessory.description
    fill_in "Discount", with: @accessory.discount
    fill_in "Imagen", with: @accessory.imagen
    fill_in "Name", with: @accessory.name
    fill_in "Price", with: @accessory.price
    fill_in "Stock", with: @accessory.stock
    fill_in "Total price", with: @accessory.total_price
    fill_in "Warranty", with: @accessory.warranty
    click_on "Create Accessory"

    assert_text "Accessory was successfully created"
    click_on "Back"
  end

  test "should update Accessory" do
    visit accessory_url(@accessory)
    click_on "Edit this accessory", match: :first

    fill_in "Category", with: @accessory.category
    fill_in "Code", with: @accessory.code
    fill_in "Color", with: @accessory.color
    fill_in "Description", with: @accessory.description
    fill_in "Discount", with: @accessory.discount
    fill_in "Imagen", with: @accessory.imagen
    fill_in "Name", with: @accessory.name
    fill_in "Price", with: @accessory.price
    fill_in "Stock", with: @accessory.stock
    fill_in "Total price", with: @accessory.total_price
    fill_in "Warranty", with: @accessory.warranty
    click_on "Update Accessory"

    assert_text "Accessory was successfully updated"
    click_on "Back"
  end

  test "should destroy Accessory" do
    visit accessory_url(@accessory)
    click_on "Destroy this accessory", match: :first

    assert_text "Accessory was successfully destroyed"
  end
end
