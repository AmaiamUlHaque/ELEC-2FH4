clc; %clear the command window 
clear; %clear all variables 
 
NumberOfTurns=20; %Number of turns of the solenoid 
Radius=0.1; %radius of solenoid 
Zmin=-0.5;  %coordinate of the lowest point on the solenoid 
Zmax=0.5;  %coordinate of the highest point on the solenoid 
t_min=0; %lowest value of the curve parameter t 
t_max=NumberOfTurns*2.0*pi; % for every turn we have an angle increment of 2*pi 
NumberOfSegments=100; %we divide the solenoid into this number of segments 
t_values=linspace(t_min,t_max, (NumberOfSegments+1))'; %these are the values of the parameter t 
x_values=Radius*cos(t_values); 
y_values=Radius*sin(t_values); 
z_values=Zmin+((Zmax-Zmin)/(t_max-t_min))*(t_values-t_min); 
I=3; %value of surface current density 

NumberOfXPlottingPoints=20;  %number of plotting points along the x axis 
NumberOfZPlottingPoints=20;  %number of plotting points along the z axis 
PlotXmin=-0.5;  %lowest x value on the plot plane 
PlotXmax=0.5;   %maximum x value on the plot plane 
PlotZmin=-1;  %lowest z value on the plot plane 
PlotZmax=1;   %maximum z value on the plot plane 
PlotStepX= (PlotXmax-PlotXmin)/(NumberOfXPlottingPoints-1);%plotting step in the x direction 
PlotStepZ=(PlotZmax-PlotZmin)/(NumberOfZPlottingPoints-1); %plotting step in the z direction 
[XData,ZData]=meshgrid(PlotXmin:PlotStepX:PlotXmax, PlotZmin:PlotStepZ:PlotZmax); %build arrays of plot plane 
PlotY=0; %all points on observation plane have zero y coordinate 
Bx=zeros(NumberOfXPlottingPoints,NumberOfZPlottingPoints); %x component of field 
Bz=zeros(NumberOfXPlottingPoints, NumberOfZPlottingPoints);%z component of field 
for m=1:NumberOfXPlottingPoints %repeat for all plot points in the x direction 
    for n=1:NumberOfZPlottingPoints %repeat for all plot points in the z direction 
        PlotX=XData(m,n); %x coordinate of current plot point 
        PlotZ=ZData(m,n); %z coordinate of current plot point 
        Rp=[PlotX PlotY  PlotZ]; %poistion vector of observation points 
        for i=1:NumberOfSegments %repeat for all line segments of the solenoid 
            XStart=x_values(i,1);  %x coordinate of the start of the current line segment 
            XEnd=x_values(i+1,1);  %x coordinate of the end of the current line segment 
            YStart=y_values(i,1);  %y coordinate of the start of the current line segment 
            YEnd=y_values(i+1,1);  %y coordinate of the end of the current line segment 
            ZStart=z_values(i,1);  %z coordinate of the start of the current line segment 
            ZEnd=z_values(i+1,1);  %z coordinate of the end of the current line segment 
            dl=[(XEnd-XStart)  (YEnd-YStart)  (ZEnd-ZStart)]; %the vector of diffential length 
            Rc=0.5*[(XStart+XEnd)  (YStart+YEnd)  (ZStart+ZEnd)];%position vector of center of segment 
            R=Rp-Rc; %vector pointing from current subsection to the current observation point 
            norm_R=norm(R); %get the distance between the current surface element and the observation point 
            R_Hat=R/norm_R; %unit vector in the direction of R 
            dH=(I/(4*pi*norm_R*norm_R))*cross(dl,R_Hat); %this is the contribution from current element 
            Bx(m,n)=Bx(m,n)+dH(1,1); %increment the x component at the current observation point 
            Bz(m,n)=Bz(m,n)+dH(1,3); %increment the z component at the current observation point 
        end %end of i loop 
   end %end of n loop 
end % end of m loop 
quiver(XData, ZData, Bx, Bz);
xlabel('x(m)');%label x axis 
ylabel('z(m)');%label z axis