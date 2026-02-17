clc; %clear the command line 
clear; %remove all previous variables 

O=[0 0 0]%the origin              
M=[0.1 -0.2 -0.1]; %Point M 
N=[-0.2 0.1 0.3]; %Point N 
P=[0.4 0 0.1] %Point P 

R_MO=M-O;%vector R_MO 
R_NO=N-O;%vector R_NO 
R_PO=P-O;%vector R_PO 
R_NM=R_MO-R_NO;%vector R_NM 
R_PM=R_MO-R_PO;%vector R_PM 

R_PM_dot_R_NM=dot(R_PM,R_NM);%the dot product of R_PM and R_NM 
R_PM_dot_R_PM=dot(R_PM,R_PM);%the dot product of R_PM and R_PM 

Proj_R_NM_ON_R_PM=(R_PM_dot_R_NM/R_PM_dot_R_PM)*R_PM;%the projection of R_NM ON R_PM 

Mag_R_NM=norm(R_NM);%the magnitude of R_NM Mag_R_PM=norm(R_PM);%the magnitude of R_PM 

COS_theta=R_PM_dot_R_NM/(Mag_R_PM*Mag_R_NM);%this is the cosine value of the angle 
between R_PM and R_NM  theta=acos(COS_theta);%the angle between R_PM and R_NM