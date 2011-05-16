require 'spec_helper'

class MyClass
  include GeoUnits
end

describe GeoUnits do
  describe 'module methods' do
    describe '#valid_units?' do
      it 'should list valid units' do
        GeoUnits.valid_units?.should include(:kms, :meters)
      end
    end
  end
end