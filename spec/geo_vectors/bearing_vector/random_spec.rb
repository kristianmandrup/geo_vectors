require 'spec_helper'

describe GeoVector do
  describe 'Random module' do
    context 'Bearing vector 4.km at 52 deg' do
      describe '#random_vector' do      
        let (:vec) { vec = [4.km, 52].b_vector }
        
        it 'should return a random vector of up to 4.kms with any bearing' do
          rvec = vec.random_vector
          rvec.distance.in_kms.should be_between(0, 4)
          puts "random bearing: #{rvec.bearing}"
          rvec.bearing.should be_between(0, 360)
        end
      end
    end
  end
end