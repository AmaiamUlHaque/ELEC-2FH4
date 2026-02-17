%% QUESTION INFO

% Given  the  vectors  R1=ax+2ay+3az,  R2=3ax+2ay+az.  

% Find  
% a)  the  dot roduct R1 * R2,  
% b)  the projection  of R1 on R2,  
% c)  the  angle  between R1 and R2.  

% Write  a  MATLAB  program  to  verify  your answer.

%% define vectors

R1 = [1 2 3];
R2 = [3 2 1];

%% PART A

dot_R1_R2 = dot (R1,R2)

%% PART B

% proj A on B: (A dot a_B) a_B
unit_R2 = R2 / norm(R2);
proj_R1_on_R2 = unit_R2 * dot(R1, unit_R2)

%% PART C

% A dot B = |A||B| cos(thetaAB)

theta_R1_R2 = acos(dot_R1_R2 / (norm(R1)*norm(R2)))