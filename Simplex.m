clear all;
close all;
% Standard parameters
A = NaN(1,1000);
B = 0.05
N = 1000
A1=[1  0.5;0.5 1]; 
A2=[1  -0.5;-0.5 1];
m1=[-10,-10]'; 
m2=[10,10]';
% Start value of alpha
A(1) = 2
% 2d start points
S = [1,2;3,4;6,1]';

% Save Errror values for plotting. 
JJ = NaN(1,1000);

% Saving the errors of each start value and pick out the largest.
X = NaN(1,3)
X(1) = J(S(:,1),m1,m2,A1,A2);
X(2) = J(S(:,2),m1,m2,A1,A2);
X(3) = J(S(:,3),m1,m2,A1,A2);

JJ(1) = X(1);
JJ(2) = X(2);
JJ(3) = X(3);

% Find the index in X that corresponds to the position to be remove in S.
maxindex = find(X == max(X));
% Remove the values that corresponds to the highest J. 
Swithoutmax = S(:,[1:maxindex-1 maxindex+1:end]);
% Calculating centroid
c = (1/2)*sum(Swithoutmax,2);
% replace the point in S with the highest corresponding J value.
S(:,maxindex) = c + A(1)*(c-S(:,maxindex));
X(maxindex) = J(S(:,maxindex),m1,m2,A1,A2);
JJ(4) = X(maxindex);
R = 4;


 
 while (norm(JJ(R)-JJ(R-1))/norm(JJ(R-1)) > 10e-5)
 if JJ(R) > JJ(R-1) 
     % If the error is growing we reduce the alpha parameter.
     A(R-2) = (1-B)*A(R-3);
 else
     % If the error is reducing we reduce the alpha parameter.
     A(R-2) = (1+B)*A(R-3);
 end
 
 % Create a centroid for the 2 lowest values. 
 maxindex = find(X == max(X));
 Swithoutmax = S(:,[1:maxindex-1 maxindex+1:end]);
 c = (1/2)*sum(Swithoutmax,2);
 % Replace the last 
 S(:,maxindex) = c + A(R-2)*(c-S(:,maxindex));
 X(maxindex) = J(S(:,maxindex),m1,m2,A1,A2);
 R = R+1;
 JJ(R) = X(maxindex);
 end
% 
 t1 = 1:length(JJ);
 t2 = 1:length(A);
% 
 subplot(2,1,1), plot(t1,JJ)
 subplot(2,1,2), plot(t2,A)

