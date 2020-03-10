
N = 100;

L = 0.20;

xb = L + rand(1,N)*(1-2*L);
yb = L + rand(1,N)*(1-2*L);
angs = rand(1,N)*360;
xe = xb + L*cosd(angs);
ye = yb + L*sind(angs);

ax = axes;
plot(ax,[xb;xe],[yb;ye])
axis square

hold on
glines = 0:L:1;
for i = 1:length(glines)
   xline(ax, glines(i)); 
end

n = sum(floor(xb/L) ~= floor(xe/L));
piEstimate = 2 * N / n

title("Estimate of \pi is " + piEstimate)
