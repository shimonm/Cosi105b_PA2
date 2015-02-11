# Cosi105b_PA2 <a href="https://codeclimate.com/github/shimonm/Cosi105b_PA2"><img src="https://codeclimate.com/github/shimonm/Cosi105b_PA2/badges/gpa.svg" /></a>
Cosi 105b - Software Engineering and Architecture at Scale - Movies part 2

------------------------------------
<b>To run the code, run main_program.rb </b>
------------------------------------

Final work product
------------------------------------

•	CodeClimate: https://codeclimate.com/github/shimonm/Cosi105b_PA2

•	GitHub repo: https://github.com/shimonm/Cosi105b_PA2

•	The Algorithm. A description of your prediction algorithm and what you think are its advantages and drawbacks.
o	The prediction algorithm takes the 30 most similar users to user u and collects ten reviews they gave to movie m, it then averages that value and returns a prediction of that value weighted 30% and the average rating for the movie weighted 70%. If no user that is similar to u had seen movie m, we return the overall popularity of movie m, which is an average of all ratings that movie got. 

o	Some of the advantages of this algorithm is that we take a weighted average of both the global average of the ratings and the average rating of the most similar users to u. As we improve on our algorithm for the most similar users, we will find that our prediction is better. Also, I have found that as the number of ratings goes up, the global average rating for movie m, falls short of predicting what user u will rate movie m, but actually the most similar users average rating makes our prediction more accurate. 

o	A big drawback of this algorithm is that it need to calculate the most similar users to user u on every predict(u,m) call, and that takes a long time when we want to predict a lot of users’ ratings. Another drawback is that the algorithm depends on the accuracy of most_similar(u) which might be a flawed algorithm from the first place. 

•	The Analysis. A description of the result of running some experiments to determine the accuracy of your method (using the z.run_test(k) method and the MovieTest methods.

o	I concentrate mostly on finding the best ratio of weights between the estimated most similar users average rating and the global average rating for that movie. With small sizes of k (<100) we can see that 70% on the global average gives a better estimate, because the rms is lowest. With large sizes of k (>1000) we can see that 30% on the global average gives a better estimate.

o	In terms of running time, 

•	K = 100, rms = 0.95, running time = 8.11 seconds

•	K = 1000, rms = 1.055 , running time = 94.58 seconds

•	K = 10000, rms = 1.043, running time = 671.22 seconds

•	As we can see the running time only grows linearly, or at best logarithmically as we increase by a factor of 10. 

