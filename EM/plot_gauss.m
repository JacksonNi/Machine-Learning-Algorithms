function  plot_gauss(data, mean, covar,xaxis,yaxis, colorLabel, markerLabel, MS, LW)
% PLOT_GAUSS:  plot_gauss(data, mean, covar,xaxis,yaxis)
%
%  MATLAB function to plot a 2 dimensional scatter plot of
%  sample data (using xaxis and yaxis as the column indices into
%  an N x d data matrix) and superpose the mean of a Gaussian
%  model and its "covariance ellipse"  on this data.
%                                      ICS 274 Demo Function
%
%  INPUTS:
%    data: N x d matrix of d-dimensional feature vectors
%   means: 1 x d matrix: the d-dimensional mean of the Gaussian model
%   covar: d x d matrix: the dxd covariance matrix of the Gaussian model
%   xaxis: an integer between 1 and d indicating which of the features is 
%         to be used as the x axis
%   yaxis: another integer between 1 and d for the y axis



plot(data(:,xaxis),data(:,yaxis),[colorLabel markerLabel], 'MarkerSize', MS, 'LineWidth', LW);
hold on
 plot(mean(xaxis),mean(yaxis),['kp'], 'MarkerSize', MS, 'LineWidth', LW);


% Calculate contours for the 2d normals at Mahalanobis dist = constant
mhdist = 3;

% Extract the relevant dimensions from the ith component matrix
 covar2d = [covar(xaxis,xaxis) covar(xaxis,yaxis); covar(yaxis,xaxis) covar(yaxis,yaxis)];


% Use some results from standard geometry to figure out the ellipse
% equations from the covariance matrix. Probably other ways to
% do this, e.g., finding the principal component directions, etc.
% See Fraleigh, p.431 for details on rotating the ellipse, etc
 icov = inv(covar2d);
 a = icov(1,1);
 c = icov(2,2);
% we don't check if this is zero: which occasionally causes
% problems when we divide by it later! needs to be fixed.
 b = icov(1,2)*2;

 theta = 0.5*acot( (a-c)/b);
 if isnan(theta)
     theta = 0;
 end

 sc = sin(theta)*cos(theta);
 c2 = cos(theta)*cos(theta);
 s2 = sin(theta)*sin(theta);

 a1 = a*c2 + b*sc + c*s2;
 c1 = a*s2 - b*sc + c*c2;

 th= 0:2*pi/100:2*pi;

 x1 = sqrt(mhdist/a1)*cos(th);
 y1 = sqrt(mhdist/c1)*sin(th);
 
 x = x1*cos(theta) - y1*sin(theta) + mean(xaxis);
 y = x1*sin(theta) + y1*cos(theta) + mean(yaxis);
% plot the ellipse 
 plot(x,y,'k', 'MarkerSize', MS, 'LineWidth', LW )

