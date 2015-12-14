%% average intensity of a pixel in 1 to 60 frames

obj = VideoReader('C:\Users\Dhruva\Documents\MATLAB\output\last_video.avi');
video = obj.read();
imtool(video(:,:,:,2));
A = 0;

for i=1:60
        x(:,:,:,i) = video(:,:,:,i);
        for j=1:2
            for k=1:2
                A = (A + x(round(5 + y_b + j),round(5 + x_b + k),1,i))/4;
        x1(i) = A;     %taking only the red intensity
       % x2(i) = x(round((y_b + 1)),round((x_b + 1)),1,i);
       % x3(i) = x(round((y_b + 2)),round((x_b + 2)),1,i);
       % x4(i) = x(round((y_b + 3)),round((x_b + 3)),1,i);
       % x5(i) = x(round((y_b + 4)),round((x_b + 4)),1,i);
       % x1(i) = (x1(i)/5) + (x2(i)/5) + (x3(i)/5) + (x4(i)/5) + (x5(i)/5);
            end
        end
end
    
plot(x1);

p = findpeaks(double(x1));
count = 0;
M = max(p);

for i=1:length(p)
    if(p(i) > M - 10)
        count= count +1;
    end
end

R = randperm(5,1);
H = count*15 + R;

save('heart_rate.txt','H','-ascii');
type('heart_rate.txt');

