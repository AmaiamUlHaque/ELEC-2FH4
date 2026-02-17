%% QUESTION INFO

% The open surfaces below identify a closed surface.

% p = 2.0 m and p = 4.0 m, 
% z = 3.0 m  and z = 5.0 m,
% phi = 20 deg and phi = 60 deg 

% Find 
% a) the enclosed volume, 
% b) the total area of the enclosed surface. 

% Write a MATLAB program to verify your answers.


%% PART A

V=0;    %initialize volume of the closed surface to 0  
S1=0;   %initialize the area of S1 to 0  
S2=0;   %initialize the area of S1 to 0  
S3=0;   %initialize the area of S1 to 0  
S4=0;   %initialize the area of S1 to 0  
S5=0;   %initialize the area of S1 to 0  
S6=0;   %initialize the area of S1 to 0  
rho=2;  %initialize rho to the its lower boundary   
z=3;    %initialize z to the its lower boundary   
phi= 2*pi*20/360; %initialize phi to the its lower boundary --> 20/360 = phi/2*pi --> phi = 20*2*pi/360

rho_steps=100; %initialize the rho discretization 
phi_steps=100; %initialize the phi discretization 
z_steps=100;   %initialize the z discretization

d_rho = (4-rho)/rho_steps;
d_phi = (2*pi*60/360 - phi)/phi_steps;
d_z = (5-z)/z_steps;

for k=1:z_steps
    for j=1:phi_steps
        for i=1:rho_steps
            V = V + rho*d_rho*d_phi*d_z;
        end
        rho = rho + d_rho;
    end
    rho = 2;
end


%% PART B

rho1=2;%radius of S1 
rho2=4;%radius of s2 

for k=1:z_steps 
    for i=1:phi_steps 
       S1=S1+rho1*d_phi*d_z;%get contribution to the the area of S1 
       S2=S2+rho2*d_phi*d_z;%get contribution to the the area of S2 
    end 
end 


%%the following routing calculate the area of S3 and S4 
rho=2;%reset rho to it's lower boundaty 
for j=1:rho_steps 
    for i=1:phi_steps 
       S3=S3+rho*d_phi*d_rho;%get contribution to the the area of S3 
    end 
    rho=rho+d_rho;%p increases each time when phi has been traveled from it's lower boundary to it's upper boundary 
end 
S4=S3;%the area of S4 is equal to the area of S3 
  

%%the following routing calculate the area of S5 and S6 
for k=1:z_steps 
    for j=1:rho_steps 
       S5=S5+d_z*d_rho;%get contribution to the the area of S3 
    end 
end 
S6=S5;%the area of S6 is equal to the area of S6 
S=S1+S2+S3+S4+S5+S6; %the area of the enclosed surface
