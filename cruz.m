N = 100;

L = 1;

xb = L + rand(1,(N/2))*(1-2*L);
yb = L + rand(1,(N/2))*(1-2*L);

xb1 = L + rand(1,(N/2))*(1-2*L);
yb1 = L + rand(1,(N/2))*(1-2*L);

angs = rand(1,(N/2))*90;
a=90;
b=180;
angs1 =(b-a).* rand(1,(N/2)) + a;
disp(angs1);

xe = xb + L*cosd(angs);
ye = yb + L*sind(angs);

xe1 = xb + L*cosd(angs1);
ye1 = yb - L*sind(angs1);
ax = axes;
plot(ax,[xb;xe],[yb;ye])
plot(ax,[xb1;xe1],[yb1;ye1])
axis square

hold on
glines = 0:L:1;
for i = 1:length(glines)
   xline(ax, glines(i)); 
end