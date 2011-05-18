require 'spec_helper'

class GeoUnitClass
  extend GeoUnits
end

describe GeoUnits do
  describe 'module methods' do
    before do
      @gu = GeoUnitClass
    end
    
    describe '#valid_units?' do
      it 'should list valid units' do
        @gu.valid_units.should include(:kms, :meters)
      end
      
      it 'should be that :km is a valid unit' do
        @gu.valid_unit? :km
      end
    end
  end
end