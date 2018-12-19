defmodule MangoWeb.Acceptance.OrderTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    # enter a few orders
    # log in a user
    :ok
  end
  test "lists all orders for currently logged in customer" do
    # navigate_to("/orders")
  end

  test "view order button shows complete order details" do

  end

  test "currently logged in customer cannot view orders that are not theirs" do

  end
end
