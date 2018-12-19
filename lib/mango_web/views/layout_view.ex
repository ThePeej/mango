defmodule MangoWeb.LayoutView do
  use MangoWeb, :view
  import MangoWeb.CartView, only: [cart_count: 1]

  def cart_link_text(conn) do
    raw """
    <span class="cart-count">Cart: #{cart_count(conn)}</span>
    """
  end
end
