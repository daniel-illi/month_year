require 'month_year/version'

class MonthYear

  attr_reader :year, :month

  class << self
    # Instantiate a `MonthYear` object from a `Date`-like object
    # (a `Date` or `Time` instance,
    # or in fact from any object responding to :year and :month).
    #
    # Example:
    #   >> MonthYear.from_date(Date.today)
    #   => #<MonthYear:0x00000001f15c10 @month=12, @year=2016>
    #
    # Arguments:
    #   date: (Date)
    #
    def from_date(date)
      raise ArgumentError unless [:year, :month].all? {|v| date.respond_to?(v) }
      self.new(date.year, date.month)
    end

    def load(month_year)
      raise_load_error(month_year) unless month_year.is_a?(Integer)
      year = month_year / 100
      month = month_year % 100
      self.new(year, month)
    end

    def dump(month_year)
      raise_dump_error(month_year) unless month_year.is_a?(self)
      month_year.to_i
    end
  end

  # Instantiate a new `MonthYear` object.
  #
  # Example:
  #   >> MonthYear.new(2016, 12)
  #   => #<MonthYear:0x00000001f15c10 @month=12, @year=2016>
  #
  # Arguments:
  #   year: (Integer)
  #   month: (Integer)
  #
  def initialize(year, month)
    raise ArgumentError unless [year, month].all? {|v| Fixnum === v }
    raise ArgumentError unless (1..12).cover?(month)
    @year, @month = year, month
  end

  def ==(other)
    self.class == other.class && (self <=> other) == 0
  end
  alias_method :eql?, :==

  def <=>(other)
    (year <=> other.year).nonzero? || month <=> other.month
  end

  def hash
    to_i.hash
  end

  def succ
    if month == 12
      self.class.new(year+1, 1)
    else
      self.class.new(year, month+1)
    end
  end
  alias_method :next, :succ

  # Return the numeric representation of this `MonthYear` instance.
  #
  # Example:
  #   >> MonthYear.new(2016, 12).to_i
  #   => 201612
  #
  def to_i
    year * 100 + month
  end

  # Return the string representation of this `MonthYear` instance.
  #
  # Example:
  #   >> MonthYear.new(2016, 12).to_s
  #   => "2016-12"
  #
  def to_s
    "#{year}-#{month.to_s.rjust(2, '0')}"
  end

  private

  class << self
    def active_record?
      Object.const_defined?("::ActiveRecord::SerializationTypeMismatch")
    end

    def argument_error_class
      active_record? ? ::ActiveRecord::SerializationTypeMismatch : ArgumentError
    end

    def raise_load_error(obj)
      raise argument_error_class, "Argument was supposed to be an Integer, but was a #{obj.class}. -- #{obj.inspect}"
    end

    def raise_dump_error(obj)
      raise argument_error_class, "Argument was supposed to be a #{self}, but was a #{obj.class}. -- #{obj.inspect}"
    end
  end
end
