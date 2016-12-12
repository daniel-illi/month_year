require 'month_year/version'

class MonthYear

  attr_reader :month, :year

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
      self.new(date.month, date.year)
    end

    def load(month_year)
      raise_load_error(month_year) unless month_year.is_a?(Integer)
      month = month_year % 100
      year = month_year / 100
      self.new(month, year)
    end

    def dump(month_year)
      raise_dump_error(month_year) unless month_year.is_a?(self)
      month_year.to_i
    end
  end

  # Instantiate a new `MonthYear` object.
  #
  # Example:
  #   >> MonthYear.new(12, 2016)
  #   => #<MonthYear:0x00000001f15c10 @month=12, @year=2016>
  #
  # Arguments:
  #   month: (Integer)
  #   year: (Integer)
  #
  def initialize(month, year)
    raise ArgumentError.new("arguments must be integers") unless [month, year].all? {|v| Fixnum === v }
    raise ArgumentError.new("month argument must be between 1 and 12") unless (1..12).cover?(month)
    @month, @year = month, year
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
      self.class.new(1, year + 1)
    else
      self.class.new(month + 1, year)
    end
  end
  alias_method :next, :succ

  # Return the numeric representation of this `MonthYear` instance.
  #
  # Example:
  #   >> MonthYear.new(12, 2016).to_i
  #   => 201612
  #
  def to_i
    year * 100 + month
  end

  # Return the string representation of this `MonthYear` instance.
  #
  # Example:
  #   >> MonthYear.new(12, 2016).to_s
  #   => "2016-12"
  #
  def to_s
    "#{year}-#{month.to_s.rjust(2, '0')}"
  end

  private

  class << self
    def raise_active_record_error?
      ! (Object.const_get("::ActiveRecord::SerializationTypeMismatch") rescue nil).nil?
    end

    def argument_error_class
      raise_active_record_error? ? ::ActiveRecord::SerializationTypeMismatch : ArgumentError
    end

    def raise_load_error(obj)
      raise argument_error_class, "Argument was supposed to be an Integer, but was a #{obj.class}. -- #{obj.inspect}"
    end

    def raise_dump_error(obj)
      raise argument_error_class, "Argument was supposed to be a #{self}, but was a #{obj.class}. -- #{obj.inspect}"
    end
  end
end
