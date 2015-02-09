class MovieTest
  def initialize(list)
    @list = list
  end

  attr_reader :list

  # returns the average predication error (which should be close to zero)
  def mean
    sum = 0.0
    list.each do |i|
      sum += i[:r] - i[:p]
    end
    sum / list.size
  end

  # returns the standard deviation of the error
  def stddev
    sum = 0.0
    list.each do |i|
      sum += (i[:p] - i[:r] - mean)**2
    end
    Math.sqrt(sum / (list.size - 1))
  end

  # returns the root mean square error of the prediction
  def rms
    sum = 0.0
    list.each do |i|
      sum += (i[:r] - i[:p])**2
    end
    Math.sqrt(sum / list.size)
  end

  # returns an array of the predictions in the form [u,m,r,p].
  def to_a

  end

  def to_s
    list
  end
  # You can also generate other types of error measures if you want, but we will rely mostly on the root mean square error.
end