require_relative "movie_data"
require_relative "movie_test"

puts """Please enter the full path of the file you want us to process:""" #For example: /Users/shimonmazor/Dropbox/cosi105b_ShimonMazor/movies-1/u.data

# creates a new MovieData object analysing a file from the user and execute the load_data method
u1 = $stdin.gets.chomp
path = "ml-100k"#$stdin.gets.chomp
m = MovieData.new(path, :u1)

puts "m.rating(1, 6) #{m.rating(1, 6)}" # => 0
puts "m.popularity(6) #{m.popularity(6)}" # => 3.4
puts "m.predict(1,6) #{m.predict(1,6)}" # => 3.4

puts "m.rating(1, 5) #{m.rating(1, 5)}" # => 3
puts "m.popularity(5) #{m.popularity(5)}" # => 3.304
puts "m.predict(1,5) #{m.predict(1,5)}" # => 3

puts "m.movies(1) #{m.movies(1)}" # => [1, 2, 3, 4, 5, 7, 8, 9, 11, 13, 15, 16, 18, 19, 21, 22, 25, 26, 28, 29, 30, 32, 34, 35, 37, 38, 40, 41, 42, 43, 45, 46, 48, 50, 52, 55, 57, 58, 59, 63, 66, 68, 71, 75, 77, 79, 83, 87, 88, 89, 93, 94, 95, 99, 101, 105, 106, 109, 110, 111, 115, 116, 119, 122, 123, 124, 126, 127, 131, 133, 135, 136, 137, 138, 139, 141, 142, 144, 146, 147, 149, 152, 153, 156, 158, 162, 165, 166, 167, 168, 169, 172, 173, 176, 178, 179, 181, 182, 187, 191, 192, 194, 195, 197, 198, 199, 203, 204, 205, 207, 211, 216, 217, 220, 223, 231, 234, 237, 238, 239, 240, 244, 245, 246, 247, 249, 251, 256, 257, 261, 263, 268, 269, 270, 271]

puts "viewers of movie 5 #{m.viewers(5)}" # => [1, 13, 21, 28, 72, 92, 118, 130, 135, 188, 207, 234, 255, 256, 267, 270, 291, 303, 339, 345, 367, 368, 372, 374, 375, 378, 393, 399, 405, 406, 417, 422, 425, 435, 437, 447, 468, 504, 506, 546, 551, 562, 577, 593, 604, 633, 643, 648, 655, 666, 671, 682, 709, 727, 741, 763, 776, 796, 805, 814, 833, 864, 880, 886, 892, 907, 916, 919, 925]

t = m.run_test(10)
#puts t.to_s
puts t.mean
puts t.stddev
puts t.rms

#puts "Please choose a user to compare other users to:"
#user = $stdin.gets.chomp.to_i
#
## create the popularity and most_similar lists
#pop_list = m.popularity_list
#most_similar_list = m.most_similar(user)
#
## print the first and last ten elements from both lists
#m.print_ten(pop_list, most_similar_list, user)


