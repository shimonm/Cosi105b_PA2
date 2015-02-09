class MovieData

  def initialize(file_path, u = nil)
    @movie_ratings = Hash.new
    @usr_map = Hash.new

    if u
      @usr_map_test = Hash.new
      @movie_ratings_test = Hash.new

      @training_file = open(file_path + "/#{u}.base")
      @test_file = open(file_path + "/#{u}.test")

      #self.load_data(test_file, movie_ratings_test, usr_map_test)
     else
      @training_file = open(file_path + "/u.data")
    end

    self.load_data(training_file, movie_ratings, usr_map)
  end

  attr_reader :movie_ratings, :movie_ratings_test, :usr_map, :usr_map_test, :training_file, :test_file

  # load_data reads in the data from the original ml-100k
  # file and stores it in two hashes that organize it
  def load_data(file, m_r_hash, usr_movie_map)
    file.each_line do |line|
      line_entry_array = line.split(" ")#scan(/\w+/) #creates an array of every string token in the line
      line_entry_array.map! { |i| i.to_i } #converts the string array to an int array

      # assign different variable names to the data in each line_entry
      user_id = line_entry_array[0]
      movie_id = line_entry_array[1]
      rating = line_entry_array[2]

      # the following code will create a hash of movie_id as keys
      # that are mapped to arrays of values which are the different ratings

      # constructs a hash that maps movie_id's to their ratings
      #(m_r_hash[movie_id] ||= []) << rating

      m_r_hash[movie_id] ||= {}
      m_r_hash[movie_id][user_id] ||= rating

      # constructs a mapping of user_id's to a hash of movies and their ratings
      usr_movie_map[user_id] ||= {}
      usr_movie_map[user_id][movie_id] ||= rating
    end
    file.close
  end

  # returns the rating that user u gave movie m in the training set, and 0 if user u did not rate movie m
  def rating(user_id, movie_id)
    usr_map[user_id][movie_id].nil? ? 0 : usr_map[user_id][movie_id]
  end

  # returns a floating point number between 1.0 and 5.0 as an estimate of what user u would rate movie m
  def predict(user_id, movie_id)
    # this is a naive implementation which only returns the average rating of the movie as a prediction of what the user rates the movie
    usr_rating = rating(user_id, movie_id)
    (usr_rating == 0) ? popularity(movie_id) : usr_rating
  end

  # returns the array of movies that user u has watched
  def movies(user_id)
    usr_map[user_id].collect {|movie_id, rating| movie_id}
  end

  # returns the array of users that have seen movie m
  def viewers(movie_id)
    movie_ratings[movie_id].collect {|user_id, rating| user_id}
  end

  # run_test(k) runs the predict() method on the first k ratings in the test set and returns a MovieTest object containing the results.
  # The parameter k is optional and if omitted, all of the tests will be run.
  def run_test(k = nil)
    k ||= 20000

    #movie_ratings_test, usr_map_test

    list = []
    results = Struct.new(:u, :m, :r, :p)

    #test_file.each_line(k) do |line|
    (0...k).each do |j|
      line_entry_array = test_file.readline.split(" ")
      line_entry_array.map! { |i| i.to_i } #converts the string array to an int array

      ## assign different variable names to the data in each line_entry
      user_id = line_entry_array[0]
      movie_id = line_entry_array[1]
      rating = line_entry_array[2]

      movie_ratings[movie_id] ||= {}
      movie_ratings[movie_id][user_id] ||= rating

      list << results.new(user_id, movie_id, rating, predict(user_id, movie_id))


    end

    #puts "#{line_entry_array}"
    #puts "#{list}"
    #puts list

    MovieTest.new(list)
  end

  # returns the average popularity of a specific movie
  def popularity(movie_id)
    ratings = movie_ratings[movie_id]
    sum = 0.0
    ratings.each { |user_id, rating| sum += rating }
    sum / ratings.length
  end

  # generates a list of all movie_id’s ordered by decreasing popularity
  def popularity_list
    pop_list = {}

    #creates a hash where a movie id is mapped to its average_rating
    movie_ratings.each_key do |movie_id|
      pop_list[movie_id] = popularity(movie_id)
    end

    #sorts the hash by rating and prints the movie_id's in descending order
    pop_list.sort_by { |movie_id, rating_average| -rating_average}
  end

  # this will generate a number (similarity_pts) which indicates the similarity in movie preference
  # between user1 and user2 (where higher numbers indicate greater similarity)
  def similarity(user1, user2)
    user1_ratings = usr_map[user1]
    user2_ratings = usr_map[user2]

    common_map = {}

    common_ratings = user2_ratings.keys & user1_ratings.keys
    common_ratings.each { |i| common_map[user2_ratings[i]] = user1_ratings[i] }

    # if user's vote is 1-0 apart, they get: 1 or 2 points
    #										2  apart 						0 points
    #									 3-4 apart 					 -1 or -2 points
    similarity_pts = 0.0
    common_map.each_pair do |key,value|
      case (key - value).abs
        when 4
          similarity_pts += -2
        when 3
          similarity_pts += -1
        when 2
          similarity_pts += 0
        when 1
          similarity_pts += 1
        when 0
          similarity_pts += 2
        else
          similarity_pts += -3
      end
    end
    similarity_pts
  end

  # returns a list of users whose tastes are most similar to the tastes of user u
  def most_similar(u)
    most_similar_list = {}
    # for every user in the usr_map, get its similarity value with u. Then assign the value to that user.
    usr_map.keys.each do |user|
      most_similar_list[user] ||= similarity(u, user) unless user == u
    end

    # sort the list of users by highest to lowest similarity_pts
    most_similar_list.sort_by { |user_id, similarity_pts| -similarity_pts }
  end

  #	prints the first and last ten elements of pop_list and most_sim_list
  def print_ten(pop_list, most_similar_list, user)
    puts "First ten elements of popularity list:"
    (0..9).each do |i|
      puts "#{i+1}. #{pop_list[i][0]}"
    end

    puts "\nLast ten elements of popularity list:"
    d = pop_list.length-10
    (d..d+9).each do |i|
      puts "#{i+1}. #{pop_list[i][0]}"
    end

    puts "\nFirst ten elements of most_similar(#{user}):"
    (0..9).each do |i|
      puts "#{i+1}. #{most_similar_list[i][0]}"
    end

    puts "\nLast ten elements of most_similar(#{user}):"
    d = most_similar_list.length-10
    (d..d+9).each do |i|
      puts "#{i+1}. #{most_similar_list[i][0]}"
    end
  end
end
