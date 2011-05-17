require 'spec_helper'

describe GeoUnits do
  describe 'module methods' do
    describe '#valid_units?' do
      it 'should list valid units' do
        GeoUnits.valid_units.should include(:kms, :meters)
      end
      
      it 'should be that :km is a valid unit' do
        GeoUnits.valid_unit? :km
      end
    end
  end
end