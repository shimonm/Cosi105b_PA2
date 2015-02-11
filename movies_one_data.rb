# Author: Shimon Mazor
# Email: shimonm@brandeis.edu
# COSI 105B
# PA2: Movies Part 2

class MoviesOneData

  def initialize(file_path)
    @movie_ratings = Hash.new
    @usr_map = Hash.new
    @file = open(file_path)
    self.load_data
  end

  attr_accessor :movie_ratings, :usr_map, :file

  # load_data reads in the data from the original ml-100k
  # file and stores it in two hashes that organize it
  def load_data
    file.each_line do |line|
      line_entry_array = line.split(" ")#scan(/\w+/) #creates an array of every string token in the line
      line_entry_array.map! { |i| i.to_i } #converts the string array to an int array

      # assign different variable names to the data in each line_entry
      user_id = line_entry_array[0]
      movie_id = line_entry_array[1]
      rating = line_entry_array[2]

      # the following code will create a hash of movie_id as keys
      # that are mapped to arrays of values which are the different ratings
      movie_ratings[movie_id] ||= {}
      movie_ratings[movie_id][user_id] ||= rating

      # constructs a mapping of user_id's to a hash of movies and their ratings
      usr_map[user_id] ||= {}
      usr_map[user_id][movie_id] ||= rating
    end
    file.rewind
  end

  # returns the average popularity of a specific movie
  def popularity(movie_id)
    ratings = movie_ratings[movie_id]
    sum = 0.0
    if ratings.nil?
      3
    else
      ratings.each { |user_id, rating| sum += rating }
      sum / ratings.length
    end
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
    loop_ten(0, pop_list)

    puts "\nLast ten elements of popularity list:"
    loop_ten(pop_list.length-10, pop_list)

    puts "\nFirst ten elements of most_similar(#{user}):"
    loop_ten(0, most_similar_list)

    puts "\nLast ten elements of most_similar(#{user}):"
    loop_ten(most_similar_list.length-10, most_similar_list)
  end

  def loop_ten(d, list)
    (d..d+9).each do |i|
      puts "#{i+1}. #{list[i][0]}"
    end
  end

end