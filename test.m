Mean = 0;
Sat = 1;
NumOfUnits = 100;

Sat = 0.905-Sat
Variance = exp(Sat*9)
x_gaussian = 0:1:255;
y_gaussian = gaussmf(x_gaussian,[Variance Mean]);
y_gaussian(y_gaussian<0.01) = 0;
y_gaussian(y_gaussian>0.992) = 1;
y_gaussian = (y_gaussian/sum(y_gaussian)) * NumOfUnits;

SumUnits = sum(y_gaussian);
plot(x_gaussian,y_gaussian);

