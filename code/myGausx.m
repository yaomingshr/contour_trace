function Gx = myGausx(sigma)
Gx = [exp(-1/sigma^2)*(1/sigma^2) 0 exp(-1/sigma^2)*(-1/sigma^2);
      exp(-1/2*sigma^2)*(1/sigma^2) 0 exp(-1/2*sigma^2)*(-1/sigma^2);
      exp(-1/sigma^2)*(1/sigma^2) 0 exp(-1/sigma^2)*(-1/sigma^2);];
