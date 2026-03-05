%% Question info
% Given the points M(0.1,-0.2,-0.1),  N(-0.2,0.1,0.3) and P(0.4,0,0.1), 

% find: 
% a)  the vector R_NM , 
% b)  the dot product R_NM * R_PM,  
% c)  the projection  of R_NM on  R_PM  and  
% d)  the angle  between  R_NM  and  R_PM. 

% Write a MATLAB program to verify your answer.

%% ------------------------------------------------------------------------------------

% clc;
% clear;

%% define points & vectors

O = [0 0 0];
M = [0.1 -0.2 -0.1];
N = [-0.2 0.1 0.3];
P = [0.4 0 0.1];

R_M = M - O;
R_N = N - O;
R_P = P - O;


%% part A

R_NM = R_M - R_N;


%% part B

R_PM = R_M - R_P;

NM_dot_PM = dot(R_NM,R_PM);


%% part C

% proj A on B: (A dot a_B) a_B

unit_PM = R_PM / norm(R_PM); 

% proj_NMonPM = unit_PM * NM_dot_PM;
% proj_NMonPM = unit_PM * dot(R_NM,R_PM);  % (A dot B) a_B
proj_NMonPM = unit_PM * dot(R_NM,unit_PM); % (A dot a_B) a_B


%% part D

% A dot B = |A||B| cos(thetaAB)

theta_NM_PM = acos(NM_dot_PM / (norm(R_NM)*norm(R_PM)));



