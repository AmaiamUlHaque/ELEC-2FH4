%% QUESTION INFO

% The surfaces below define a closed surface:

% r = 0 and r = 2,
% phi = 45 and phi = 90
% theta = 45 and theta = 90 

% Find  the  enclosed  volume  and  the  area  of  the  closed  surface  S.  

% Write  a  MATLAB  program  to  verify  your answer.


%% Initialisations

V=0;    %initialize volume of the closed surface to 0  
S1=0;   %initialize the area of S1 to 0  
S2=0;   %initialize the area of S2 to 0  
S3=0;   %initialize the area of S3 to 0  
S4=0;   %initialize the area of S4 to 0  
S5=0;   %initialize the area of S5 to 0  


r1=0;  %initialize r1 to the its lower boundary
r2=2;  %initialize r1 to the its upper boundary   

phi1 = 2*pi*45/360; %initialize phi1 to the its lower boundary
phi2 = 2*pi*90/360; %initialize phi1 to the its upper boundary

theta1=2*pi*45/360; %initialize theta1 to the its lower boundary   
theta2=2*pi*90/360; %initialize theta2 to the its upper boundary   

r_steps=100; %initialize the r discretization 
phi_steps=100; %initialize the phi discretization 
theta_steps=100;   %initialize the theta discretization

d_r = (r2-r1)/rho_steps;
d_phi = (phi2-phi1)/phi_steps;
d_theta = (theta2-theta1)/theta_steps;


%% Volume calculation

for k=1:theta_steps
    for j=1:phi_steps
        for i=1:r_steps
            V = V + r^2*sin(theta)*d_r*d_phi*d_theta;
        end
        r = r + d_r;
        %theta???
    end
    r = r1;
    %theta???
end


%% Surface calculation

