require 'spec_helper'

describe DirectionVector do
  context 'Direction Vector: 2 km North and a GeoPoint at (1,3)' do
    let(:vector) { DirectionVector.new 2.km, :north }
    let(:point)  { GeoPoint.new 1, 3 }

    describe '#+' do
      it 'should add Direction Vector to point' do      
        p2 = point + vector
        p2.should_not == point
      end
    end
  
    describe '#add (alias to +)' do
      it 'should add Direction Vector to point' do      
        p2 = point.add(vector)
        p2.should_not == point
      end
    end    

    describe '#add! changes point' do
      it 'should add Direction Vector directly to point' do      
        old_point = point.dup
        point.add!(vector)
        old_point.lat.should_not == point.lat
      end
    end    
  end
end