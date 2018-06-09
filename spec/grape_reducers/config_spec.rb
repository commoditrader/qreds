require 'spec_helper'

RSpec.describe GrapeReducers::Config do
  let(:reducible) { MockCollection.new((1..3).map { |i| SimpleObject.new(i) }) }
  let(:attr_name) { 'some_field' }

  describe '.define_reducer' do
    before(:all) do
      described_class.define_reducer(:test_reducer) do |reducer|
        reducer.operator_mapping = {}
      end
    end

    after(:all) do
      described_class.instance_variable_get(:@reducers).delete(:test_reducer)
    end

    it 'creates a reducer with defaults and allows changing any other keys' do
      reducer = described_class[:test_reducer]
      expect(reducer.functor_group).to eq(:test_reducer)
      expect(reducer.operator_mapping).to eq({})
    end
  end

  describe 'sorting reducer' do
    let(:reducer) { described_class[:sort] }

    describe 'default lambda' do
      subject { reducer.default_lambda.call(reducible, attr_name, value, nil).map(&:value) }
      let(:value) { 'desc' }

      it 'calls order with attr name and value' do
        is_expected.to eq([3, 2, 1])
      end
    end
  end

  describe 'filtering reducer' do
    let(:reducer) { described_class[:filter] }

    describe 'default lambda' do
      subject { reducer.default_lambda.call(reducible, attr_name, value, operator).map(&:value) }
      let(:value) { 2 }
      let(:operator) { '>' }

      it 'calls where with attr name, value and operator' do
        is_expected.to eq([3])
      end

      context 'when translated operator has more than one "?"' do
        let(:operator) { 'BETWEEN ? AND ?' }
        let(:value) { [2, 3] }

        it { is_expected.to eq([2, 3]) }
      end
    end

    describe 'operator mapping' do
      subject { reducer.operator_mapping }

      it 'is suited to work with PostgreSQL' do
        is_expected.to eq(
          'lt' => '< ?',
          'lte' => '<= ?',
          'eq' => '= ?',
          'gt' => '> ?',
          'gte' => '>= ?',
          'in' => 'IN (?)',
          'btw' => 'BETWEEN ? AND ?'
        )
      end
    end

    describe 'functor_group' do
      subject { reducer.functor_group }

      it { is_expected.to eq('filters') }
    end
  end
end
