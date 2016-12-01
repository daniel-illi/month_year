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

    it 'thows error with string argument' do
      expect { MonthYear.from_date('200102') }.to raise_error(ArgumentError)
    end
  end

  it '::dump returns numeric value' do
    expect(MonthYear.dump(month_year)).to eq(month_year.to_i)
  end

  it '::load instantiates from numeric value' do
    expect(MonthYear.load(month_year.to_i)).to eq(month_year)
  end

  it '#eql?'
  it '#=='
  it '#<=>'
  it '#hash'
  it '#succ'
  it '#next'
  it '#to_i'
  it '#to_s'
end