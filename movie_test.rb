class MovieTest
  
  # initialize MovieTest with an array the every slot has an array with [u,m,r,p]
  def initialize(list)
    @list = list
  end

  # returns the average predication error (which should be close to zero)
  def mean
    sum = 0.0
    @list.each do |i|
      sum += i[:p] - i[:r]
    end
    (sum / @list.size).round(3)
  end

  # returns the standard deviation of the error
  def stddev
    sum = 0.0
    @list.each do |i|
      sum += (i[:p] - i[:r] - mean)**2
    end
    Math.sqrt(sum / (@list.size - 1))
  end

  # returns the root mean square error of the prediction
  def rms
    sum = 0.0
    @list.each do |i|
      sum += (i[:r] - i[:p])**2
    end
    Math.sqrt(sum / @list.size)
  end

  # returns an array of the predictions in the form [u,m,r,p].
  def to_a
    @list.collect {|i| i.values_at(0,1,2,3)}
  end
end
