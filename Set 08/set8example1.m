
%% SET 8 EXAMPLE 1

%% QUESTION INFO
% An  electric  field E=5x10^4/p a_p V/m exists  in  cylindrical  coordinates.  
% Find  analytically  the electric energy stored in the region bounded by
% 1.0 m < p < 2.0 m, 
% -2.0 m < z < 2.0 m and
% 0 < phi < 2pi 
% as shown in Figure 8.1.
% Verify your answer using a MATLAB program. 

%% SOLUTION

clc; %clear the command line 
clear; %remove all previous variables 
 
Epsilono=1e-9/(36*pi); %use permitivity of free space 
rho_upper=2.0;%upper bound of rho 
rho_lower=1.0;%lower bound of rho 
phi_upper=2*pi;%upper bound of phi 
phi_lower=0;%lower bound of phi 
z_upper=2;%upper bound of z 
z_lower=-2;%lower bound of z 

Number_of_rho_Steps=50; %initialize discretization in the rho direction 
drho=(rho_upper-rho_lower)/Number_of_rho_Steps; %The rho increment 
Number_of_z_Steps=50; %initialize the discretization in the z direction 
dz=(z_upper-z_lower)/Number_of_z_Steps; %The z increment 
Number_of_phi_Steps=50; %initialize the phi discretization 
dphi=(phi_upper-phi_lower)/Number_of_phi_Steps; %The step in the phi direction 
 
WE=0; %the total engery stored in the region 
for k=1:Number_of_phi_Steps 
    for j=1:Number_of_z_Steps 
        for i=1:Number_of_rho_Steps            
           rho=rho_lower+0.5*drho+(i-1)*drho; %radius of current volume element 
           z=z_lower+0.5*dz+(j-1)*dz; %z of current volume element 
           phi=phi_lower+0.5*dphi+(k-1)*dphi; %phi of current volume element     
           EMag=5e4/rho;%magnitude of electric field of current volume element  
           dV=rho*drho*dphi*dz;%volume of current element 
           dWE=0.5*Epsilono*EMag*EMag*dV;%energy stored in current element 
           WE=WE+dWE;%get contribution to the total energy 
       end %end of the i loop 
   end %end of the j loop 
end %end of the k loop

WE % prints result

%% RESULT
% WE = 0.1925