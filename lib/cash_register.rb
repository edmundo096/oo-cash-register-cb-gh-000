class CashRegister

  attr_accessor :total # NOTE: Should be reader only, but rspec fails if so.
  attr_reader :discount, :items, :last

  def initialize(discount = 0)
    @total = 0
    @discount = discount
    @items = []
    @last = {}
  end

  def add_item(title, price, quantity = 1)
    @total += price * quantity
    quantity.times { @items << title }

    @last[:title] = title
    @last[:price] = price
    @last[:quantity] = quantity
    nil
  end

  def apply_discount
    return "There is no discount to apply." if @discount == 0

    @total -= @total * (@discount / 100.0)
    @total = @total.to_i
    "After the discount, the total comes to $#{@total}."
  end

  def void_last_transaction
    return nil if @last == {}
    
    @total -= @last[:price] * @last[:quantity]
    @last[:quantity].times { @items.pop }
    @last = {}
  end

end
