# Author: Shimon Mazor
# Email: shimonm@brandeis.edu
# COSI 105B
# PA2: Movies Part 2

require_relative "movie_data"
require_relative "movie_test"
require_relative "movies_one_data"

puts "Please enter the path of the file you want us to process (For example: ml-100k)"

# creates a new MovieData object analysing a file from the user and execute the load_data method
path = "ml-100k"#$stdin.gets.chomp

puts "Choose the name of the training/test set, for example u1, otherwise, press ENTER: "
u1 = $stdin.gets.chomp
m = MovieData.new(path, u1)

puts "Do you want to compare individual users? (y/n)"

answer = $stdin.gets.chomp

if answer == "y" || answer == "Y"
  puts "Comparing individual users "
  puts "Which user do you want to work on? "
  user_id = $stdin.gets.chomp.to_i
  puts "Which movie do you want to work on? "
  movie_id = $stdin.gets.chomp.to_i
  puts "Which user do you want to compare to #{user_id}? "
  compared_user_id = $stdin.gets.chomp.to_i

  m.mode = :test

  [user_id, compared_user_id].each do |u|
    prediction = m.predict(u, movie_id)
    rating = m.rating(u, movie_id)
    puts "Our prediction to the rating #{u} gave #{movie_id} is: #{prediction}"
    puts "The actual rating #{u} gave movie #{movie_id} is: #{rating}"
    puts "The difference is: #{prediction - rating}"
    puts "That's pretty good!\n"
  end
end

puts "Do you want to analyze the mean, std dev, and root mean square of the error of our prediction (y/n) "
answer = $stdin.gets.chomp
if answer == "y" || answer == "Y"

  puts "How many ratings do you want to predict (choose your k, has to be under 20,000)? "
  k = $stdin.gets.chomp.to_i
  puts "Processing......"
  time_before = Time.now
  t = m.run_test(k)
  puts "MovieTest list: #{t.to_a}"
  puts "Average predication error: #{t.mean.round(3)}"
  puts "Standard deviation of the error: #{t.stddev.round(3)}"
  puts "Root mean square error of the prediction: #{t.rms.round(3)}"
  puts "It took #{Time.now - time_before} seconds to complete."
end

puts "Do you want to run the script for movies-1 to print the popularity list and the 10 most similar? (y/n) "
answer = $stdin.gets.chomp
if answer == "y" || answer == "Y"
  m.mode = :training
  puts "Please choose a user to compare other users to:"
  user = $stdin.gets.chomp.to_i

  # create the popularity and most_similar lists
  pop_list = m.training_set.popularity_list
  most_similar_list = m.training_set.most_similar(user)

  # print the first and last ten elements from both lists
  m.training_set.print_ten(pop_list, most_similar_list, user)
end
