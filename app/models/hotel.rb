class Hotel
  attr_accessor :id, :name, :price, :afterTaxPrice

  def initialize(id, name, price, afterTaxPrice)
    @id = id
    @name = name
    @price = price
    @afterTaxPrice = afterTaxPrice
  end
end