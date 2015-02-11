require_relative "movie_data"
require_relative "movie_test"
require_relative "movies_one_data"

puts """Please enter the full path of the file you want us to process:""" #For example: /Users/shimonmazor/Dropbox/cosi105b_ShimonMazor/movies-1/u.data

# creates a new MovieData object analysing a file from the user and execute the load_data method
u1 = $stdin.gets.chomp
path = "ml-100k"#$stdin.gets.chomp
m = MovieData.new(path, u1)

#puts "Which user do you want to work on? "
#user_id = $stdin.gets.chomp.to_i
#puts "Which movie do you want to work on? "
#movie_id = $stdin.gets.chomp.to_i
#puts "Which user do you want to compare to #{user_id}? "
#compared_user_id = $stdin.gets.chomp.to_i


#puts m.test_set.movie_ratings[599]
#puts m.test_set.movie_ratings[711]


#m.mode = :test
#puts m.predict(user_id, movie_id)
#puts m.predict(compared_user_id, movie_id)

#puts "#{m.set.most_similar(user_id)}"
#puts "#{m.set.most_similar(user_id).collect {|u, r| u}}" #returns an array of most similar users to u
#usr_arr = m.set.most_similar(user_id).collect {|u, r| u}
#puts "default mode is training type m.mode = :test for test mode"
#puts "m.rating(user_id, 288) #{m.rating(user_id, movie_id)}" # => 1
#puts m.set.popularity(movie_id) # => 3.4414225941422596
#puts "m.rating(#{compared_user_id}, #{movie_id})#{m.rating(compared_user_id, movie_id)}"
#
#sum = 0.0
#puts "#{usr_arr.collect {|i| m.rating(i, movie_id)}}"
#u = usr_arr.collect {|i| if m.rating(i, movie_id)!=0 then m.rating(i, movie_id) end}
#puts "#{u.compact[0..9].size} #{u.compact[0..9].reduce(:+)}"
#
#puts u.compact[0..9].reduce(:+)/u.compact[0..9].size.to_f
#(0..10).each do |i|
#  if u[i]==0
#
#  else
#    sum+=u[i]
#  end
#end
#puts sum/10
#puts "m.predict(20,6) #{m.predict(20,6)}" # => 3.4



##puts "m.rating(20, 6) #{m.rating(20, 6)}" # => 0
##puts "m.movies(20) #{m.movies(20)}" # => [288, 208, 11, 176, 118, 186, 172, 678, 194, 405, 1, 69, 742, 597, 931, 95, 121, 252, 568, 144, 98, 87, 498, 588, 866, 423, 181, 94, 763, 934, 210, 174, 820, 357, 151, 148, 378, 274, 496, 143, 633, 323, 22, 50, 243, 82, 204, 15]
##m.mode = :test
#puts m.training_set.usr_map[20]
#puts m.training_set.movie_ratings[288]
#puts "m.rating(20, 6) #{m.rating(20, 6)}" # => 0
#puts "m.set.popularity(6) #{m.set.popularity(6)}" # => 3.4
#puts "m.predict(20,6) #{m.predict(20,6)}" # => 3.4
##
#puts "m.rating(20, 288) #{m.rating(20, 288)}" # => 1
#puts "m.set.popularity(5) #{m.set.popularity(5)}" # => 3.304
#puts "m.predict(1,5) #{m.predict(1,5)}" # => 3
##
#puts "m.movies(20) #{m.movies(20)}" # => [288, 208, 11, 176, 118, 186, 172, 678, 194, 405, 1, 69, 742, 597, 931, 95, 121, 252, 568, 144, 98, 87, 498, 588, 866, 423, 181, 94, 763, 934, 210, 174, 820, 357, 151, 148, 378, 274, 496, 143, 633, 323, 22, 50, 243, 82, 204, 15]
##
#puts "viewers of movie 5 #{m.viewers(5)}" # => [1, 13, 21, 28, 72, 92, 118, 130, 135, 188, 207, 234, 255, 256, 267, 270, 291, 303, 339, 345, 367, 368, 372, 374, 375, 378, 393, 399, 405, 406, 417, 422, 425, 435, 437, 447, 468, 504, 506, 546, 551, 562, 577, 593, 604, 633, 643, 648, 655, 666, 671, 682, 709, 727, 741, 763, 776, 796, 805, 814, 833, 864, 880, 886, 892, 907, 916, 919, 925]
#


t = m.run_test(1000)
puts "#{t.to_a}"
puts t.mean.round(3)
puts t.stddev.round(3)
puts t.rms.round(3)




#puts "Please choose a user to compare other users to:"
#user = $stdin.gets.chomp.to_i
#
## create the popularity and most_similar lists
#pop_list = m.training_set.popularity_list
#most_similar_list = m.training_set.most_similar(user)
#
## print the first and last ten elements from both lists
#m.training_set.print_ten(pop_list, most_similar_list, user)


# Cosi105b_PA2
