require 'spec_helper'

class Abc
  extend GeoUnits
end

describe GeoUnits do
  describe 'module methods' do
    describe '#valid_units?' do
      it 'should list valid units' do
        Abc.valid_units.should include(:kms, :meters)
      end
      
      it 'should be that :km is a valid unit' do
        Abc.valid_unit? :km
      end
    end
  end
end