require 'spec_helper'

describe GeoVector do
  describe 'PointAdd module' do
    context 'GeoPoint (0, 1)' do
      let(:point) { GeoPoint.new 3, 5 }
    
      context 'Simple vector (1, 2)' do
        let(:vector) { GeoVector.new 1, 2 }

        describe '#apply!' do
          before :each do
            @p = GeoPoint.new 3, 5
          end
          
          it 'should Add the vector: latitude=1, longitude=1' do
            @p.apply!(vector)
            @p.lat.should == 4
            @p.lng.should == 7
          end
        end

        describe '#+ (add)' do
          it 'should add the vector and create a new point from result' do
            p2 = point + vector
            point.lat.should == 1 # no change
            point.lng.should == 2
            p2.lat.should == 4 # new point should be result of addition
            p2.lng.should == 7
          end
        end

        describe '#<< (push)' do
          it 'should add the vector and create a new point from result' do
            p2 = point << vector
            point.lat.should == 1 # no change
            point.lng.should == 2
            p2.lat.should == 4 # new point should be result of addition
            p2.lng.should == 7
          end
        end
      end # context Simple vector      
    end
  end
end
