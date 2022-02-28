Image = imread("Einstein1.jpg");
I2 = im2double(Image);
T = 0.6;
Ib = I2 < T;
hist(Ib)
B = 0.4;
Iout = ~Ib*B + Ib.*I2;
hist(Iout)