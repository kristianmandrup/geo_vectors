require 'spec_helper'

describe BearingVector do
  context 'Simple vector at (1, 2) - x,y arg' do
    let(:vector) { BearingVector.new 32, 2.km }
    
    it 'should create a GeoVector: x=1, y=1' do
      vector.should be_a(BearingVector)
    end
  end
end