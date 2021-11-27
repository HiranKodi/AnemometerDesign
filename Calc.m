Vel = [1:0.01:50];      #Velocities with 0.01 increment
visc = 15.89*10^-6;     #Viscosity at 300K
Width = 5000*10^-6;     #Probe Diameter (Fixed for this calculation)
k = 0.0263;             #Thermal conductivity at 300K
ro = 10.6*10^-8;        #Resistivity of Platinum

#TO CALCULATE THE REYNOLDS NUMBER
Re = [];
l = 1;
while l <= length(Vel)
  Re(l) = (Vel(l)*Width)/visc;      #Assigning Reynolds Number for all the velocities
  l = l + 1;
endwhile


#TO ASSIGN THE PRANDTL NUMBERS
Temp = [41:1:54];       #Possible Temperatures on the probe
Pr = [0.72522, 0.72494, 0.72466, 0.72438, 0.7241, 0.72384, 0.72358, 0.72332, 0.72306, 0.7228, 0.72228, 0.72176, 0.72124, 0.72072];
Pr_air = 0.707;         #Assigning Prandtl Number for the available temperatures and air temperature

#TO CALCULATE THE CONVECTIVE HEAT TRANSFER COEFFICIENT
i = 1;
while i <= length(Temp)
  j = 1;
  while j <= length(Re)
    if Re(j) < 5*10^5
      c = 0.664;
      m = 0.5;          #Convetive heat transfer coeff calculation for Re<40
      n = 0.34;
      h(i,j) = (k*c*(Re(j)^m)*(Pr_air^n))/(Width);
    elseif 
      c = 0.037;
      m = 0.8;          #Convetive heat transfer coeff calculation for Re>40
      n = 0.34;
      h(i,j) = (k*(c*((Re(j)^m)-871)*(Pr_air^n)))/(Width);
    endif
    j = j + 1;
  endwhile
  i = i + 1;
endwhile

#TO CALCULATE THE CURRENT
x = 1;
while x <= length(Temp)
  y = 1;
  while y <= length(Re)
    I(x,y) = (2*h(x,y)*(Temp(x)-27)*(Width^3)/(1000*ro))^0.5;
    y = y+1;
  endwhile
  x = x+1;
endwhile


#TO WRITE THE DATA TO A CSV FILE
Final = [Vel',I'];
csvwrite('Final Data Set for W5000.csv',Final);


#plot(Vel,I(3,:))
#xlabel('Velocity(m/s)');
#ylabel('Current (A)');
