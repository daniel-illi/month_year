require 'coveralls'
Coveralls.wear!

require 'month_year'
require 'pry'

describe MonthYear do
  let(:date){ Date.new(2001, 2, 3) }
  let(:time){ Time.new(2001, 2, 3, 4, 5, 6, "+01:00") }
  let(:month_year){ MonthYear.new(2, 2001) }

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

  context '#new' do
    it 'raises ArgumentError when arguments are not Integer' do
      expect { MonthYear.new("5", 2000) }.to raise_error(ArgumentError)
      expect { MonthYear.new(5, "2000") }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError when month argument is not in 1..12' do
      expect { MonthYear.new(0, 2000)}.to raise_error(ArgumentError)
      expect { MonthYear.new(13, 2000)}.to raise_error(ArgumentError)
    end

    it 'initializes correct year and month attributes' do
      new_instance = MonthYear.new(month_year.month, month_year.year)
      expect(new_instance.month).to eq(month_year.month)
      expect(new_instance.year).to eq(month_year.year)
    end
  end

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
      expect(month_year).not_to eql(MonthYear.new(month_year.month + 1, month_year.year))
    end

    it 'returns false for same month but different year' do
      expect(month_year).not_to eql(MonthYear.new(month_year.month, month_year.year + 1))
    end

    it 'returns true for same year and month' do
      expect(month_year).to eql(MonthYear.new(month_year.month, month_year.year))
    end
  end

  it '#== and #eql? are the same' do
    expect(MonthYear.instance_method(:==)).to eq(MonthYear.instance_method(:eql?))
  end

  it '#succ returns the MonthYear after the current one' do
    expect(month_year.succ).to eq(MonthYear.new(month_year.month + 1, month_year.year))
  end

  it '#next and #succ are the same' do
    expect(MonthYear.instance_method(:next)).to eq(MonthYear.instance_method(:succ))
  end

  context '#<=>' do
    it 'returns 0 for same year and month' do
      expect(month_year <=> MonthYear.new(month_year.month, month_year.year)).to eq(0)
    end

    it 'returns -1 when argument is later' do
      expect(month_year <=> MonthYear.new(month_year.month + 1, month_year.year)).to eq(-1)
    end

    it 'returns 1 when argument is earlier' do
      expect(month_year <=> MonthYear.new(month_year.month - 1, month_year.year)).to eq(1)
    end
  end

  it '#hash returns the same value as #to_i.hash' do
    expect(month_year.hash).to eq(month_year.to_i.hash)
  end
end