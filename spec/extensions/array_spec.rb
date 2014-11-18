require 'dm_ruby_extensions'

describe Array do

  #------------------------------------------------------------------------------
  it 'return the value that is closest to the value in the array, rounded down' do
    expect([0,5,7,8,11,16].closest_max(6)).to eq 5
    expect([0,5,7,8,11,16].closest_max(7)).to eq 7
  end

end