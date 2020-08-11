class SearchCriteria
  attr_accessor :city, :from, :to

  def initialize()
    @city = "Pattaya"
    @from = getFormattedDate(Date.today.next_day(7))
    @to = getFormattedDate(Date.today.next_day(8))
  end

  private 

  def getFormattedDate(date)
    date.strftime("%m/%d/%y%y")
  end
end