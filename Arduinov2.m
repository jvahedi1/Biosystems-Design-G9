a = arduino();
sensor = mpu6050(a);

xlabel("Time");
ylabel("Acceleration (m/s^2)");
title("MPU6050 Acceleration");
xline = animatedline("Color","r");
yline = animatedline("Color","g");
zline = animatedline("Color","b");
axis tight;
legend("x-axis acceleration","y-axis acceleration","z-axis acceleration");

count = 1;
while count < 1000
      [accel] = readAcceleration(sensor);
      addpoints(xline,count,accel(:,1));
      addpoints(yline,count,accel(:,2));
      addpoints(zline,count,accel(:,3));
      count = count + 1;
      drawnow limitrate;
end