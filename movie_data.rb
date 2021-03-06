# Author: Shimon Mazor
# Email: shimonm@brandeis.edu
# COSI 105B
# PA2: Movies Part 2

class MovieData

  def initialize(file_path, u = nil)
    if u != ""
      @training_set = MoviesOneData.new(file_path + "/#{u}.base")
      @test_set = MoviesOneData.new(file_path + "/#{u}.test")
    else
      @training_set = MoviesOneData.new(file_path + "/u.data")
      @test_set = nil
    end
    @mode = :training
  end

  attr_accessor :training_set, :test_set, :mode

  def set
    if mode == :training
      training_set
    elsif mode == :test
      test_set
    end
  end
  # returns the rating that user u gave movie m in the training set, and 0 if user u did not rate movie m
  def rating(user_id, movie_id)
    training_set.usr_map[user_id][movie_id].nil? ? 0 : training_set.usr_map[user_id][movie_id]
  end

  # returns a floating point number between 1.0 and 5.0 as an estimate of what user u would rate movie m
  def predict(user_id, movie_id)
    movie_average_rating = set.popularity(movie_id)
    #puts "The popularity of movie #{movie_id} is #{movie_average_rating}"

    most_similar_users_list_ratings = set.most_similar(user_id)[0..29].collect do |u, r|
      if rating(u, movie_id)!=0 then
        rating(u, movie_id)
      end
    end.compact[0..9]
    #puts "Actual rating: #{rating(user_id, movie_id)}"
    #puts "most_similar_users_list_ratings: #{most_similar_users_list_ratings}"
    #puts "Prediction: #{take_average(most_similar_users_list_ratings)}"

    if most_similar_users_list_ratings.size > 0
      avg_most_similar_users_ratings = take_average(most_similar_users_list_ratings)
      0.3*avg_most_similar_users_ratings+0.7*movie_average_rating
    else
      movie_average_rating
    end
  end

  def take_average(arr)
    arr.reduce(:+)/arr.size.to_f if arr.size > 0
  end

  # returns the array of movies that user u has watched
  def movies(user_id)
    set.usr_map[user_id].collect {|movie_id, rating| movie_id}
  end

  # returns the array of users that have seen movie m
  def viewers(movie_id)
    set.movie_ratings[movie_id].collect {|user_id, rating| user_id}
  end

  # run_test(k) runs the predict() method on the first k ratings in the test set and returns a MovieTest object containing the results.
  # The parameter k is optional and if omitted, all of the tests will be run.
  def run_test(k = nil)
    mode = :test
    k = 20000 if k > 20000

    list = []
    results = Struct.new(:u, :m, :r, :p)

    #test_set.file.each_line() do |line|
    (0...k).each do |j|
      line_entry_array = test_set.file.readline.split.map! { |i| i.to_i } #converts the string array to an int array

      ## assign different variable names to the data in each line_entry
      user_id = line_entry_array[0]
      movie_id = line_entry_array[1]
      rating = line_entry_array[2]

      list << results.new(user_id, movie_id, rating, predict(user_id, movie_id))

    end
    # create and return a MovieTest object initialized with a list of structs such that [[u,m,r,p],[u,m,r,p],...]
    MovieTest.new(list)
  end

end
