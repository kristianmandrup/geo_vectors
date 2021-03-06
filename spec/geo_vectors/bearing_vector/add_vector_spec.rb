require 'spec_helper'

describe BearingVector do
  context 'Bearing Vector: 2 km at 32 degrees and a GeoPoint at (1,3)' do
    let(:vector) { BearingVector.new 32, 2.km }
    let(:point)  { GeoPoint.new 1, 3 }

    describe '#+' do
      it 'should add Bearing Vector to point' do      
        p2 = point + vector
        p2.should_not == point
      end
    end
  
    describe '#add (alias to +)' do
      it 'should add Bearing Vector to point' do      
        p2 = point.add(vector)
        p2.should_not == point
      end
    end    

    describe '#add! changes point' do
      it 'should add Bearing Vector directly to point' do      
        old_point = point.dup
        point.add!(vector)
        old_point.lat.should_not == point.lat
      end
    end    
  end
end