require 'coveralls'
Coveralls.wear!

require 'month_year'
require 'pry'

describe MonthYear do
  let(:date){ Date.new(2001, 2, 3) }
  let(:time){ Time.new(2001, 2, 3, 4, 5, 6, "+01:00") }
  let(:month_year){ MonthYear.new(2001, 2) }

  context "::from_date" do
    it 'instantiates with date argument' do
      month_year = MonthYear.from_date(date)
      expect(month_year.year).to eq(date.year)
      expect(month_year.month).to eq(date.month)
    end

    it 'instantiates with time argument' do
      month_year = MonthYear.from_date(time)
      expect(month_year.year).to eq(time.year)
      expect(month_year.month).to eq(time.month)
    end

    it 'raises error with string argument' do
      expect { MonthYear.from_date('200102') }.to raise_error(ArgumentError)
    end
  end

  context "::load" do
    it 'instantiates from integer value' do
      expect(MonthYear.load(month_year.to_i)).to eq(month_year)
    end

    it 'raises ArgumentError if argument is not an Integer' do
      expect { MonthYear.load(date) }.to raise_error(ArgumentError)
    end
  end

  context "::dump" do
    it 'returns the integer value' do
      expect(MonthYear.dump(month_year)).to eq(month_year.to_i)
    end

    it 'raises ArgumentError if argument is not a MonthYear' do
      expect { MonthYear.dump(date) }.to raise_error(ArgumentError)
    end
  end

  it '#new' # trows

  it '#to_i returns number with format YYYYMM' do
    expect(month_year.to_i).to eq(200102)
  end

  it '#to_s returns number with format "YYYY-MM"' do
    expect(month_year.to_s).to eq("2001-02")
  end

  it '::dump returns numeric value' do
    expect(MonthYear.dump(month_year)).to eq(month_year.to_i)
  end

  it '::load instantiates from numeric value' do
    expect(MonthYear.load(month_year.to_i)).to eq(month_year)
  end

  context '#==' do
    it 'returns false for same year but different month' do
      expect(month_year).not_to eql(MonthYear.new(month_year.year, month_year.month + 1))
    end

    it 'returns false for same month but different year' do
      expect(month_year).not_to eql(MonthYear.new(month_year.year + 1, month_year.month))
    end

    it 'returns true for same year and month' do
      expect(month_year).to eql(MonthYear.new(month_year.year, month_year.month))
    end
  end

  it '#== and #eql? are the same' do
    expect(MonthYear.instance_method(:==)).to eq(MonthYear.instance_method(:eql?))
  end

  context '#<=>' do
    it 'returns 0 for same year and month' do
      expect(month_year <=> MonthYear.new(month_year.year, month_year.month)).to eql(0)
    end

    it 'returns -1 when...'
    it 'returns 1 when...'
  end
  it '#succ'
  it '#next'

  it '#hash'
end