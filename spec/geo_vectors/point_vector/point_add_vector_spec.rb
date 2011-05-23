require 'spec_helper'

describe PointVector do
  describe 'PointAdd module' do
    context 'GeoPoint (3, 5)' do
      let(:point) { GeoPoint.new 3, 5 }
    
      context 'Simple vector (1, 2)' do
        let(:vector) { PointVector.new 1, 2 }

        describe '#add!' do
          before :each do
            @p = GeoPoint.new 3, 5
          end
          
          it 'should Add the vector: (1, 2)' do
            @p.add!(vector)
            @p.lat.should == 4
            @p.lng.should == 7
          end
        end

        describe '#+ (add)' do
          it 'should add the vector (1, 2) and create a new point from result' do
            p2 = point + vector
            point.lat.should == 3 # no change
            point.lng.should == 5
            p2.lat.should == 4 # new point should be result of addition
            p2.lng.should == 7
          end
        end

        describe '#<< (push)' do
          it 'should add the vector (1, 2) and create a new point from result' do
            p2 = point << vector
            point.lat.should == 3 # no change
            point.lng.should == 5
            p2.lat.should == 4 # new point should be result of addition
            p2.lng.should == 7
          end
        end
      end # context Simple vector      
    end
  end
end
