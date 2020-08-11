class SearchCriteria
  attr_accessor :city, :from, :to

  def initialize(city = "", from = "", to = "")
    @city = city.empty? ? "Pattaya" : city
    @from = from.empty? ? getFormattedDate(Date.today.next_day(7)) : from
    @to = from.empty? ? getFormattedDate(Date.today.next_day(8)) : to
  end

  private 

  def getFormattedDate(date)
    date.strftime("%y%y-%m-%d")
  end
end