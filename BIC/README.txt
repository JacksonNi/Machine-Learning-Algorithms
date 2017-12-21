For the BIC.m here, there is big problem: singular matrix, which may cause det(cov)=0
I just set the threshold of disgonal entry of covariance matrix based on the advice of question,
but the effect is not good, it really depends.

To run the code for many times, results will be very different. Sometimes, it is good, sometimes, it will cause singular problem.

Here, BIC.m is the main code.