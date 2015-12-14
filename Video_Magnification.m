%% Video Magnification
%Lowpass filter spatially

obj = VideoReader('subject15.mp4');
video = obj.read();
V = cell(3);
a = cell(60);
b = cell(60);
G = fspecial('gaussian',[3 3],0.001);
for f=1:60
    a{f} = video(:,:,:,f);
    V{1} = a{f};
    V{2}=imfilter(V{1},G,'replicate','same');   %low pass filtering
    b{f} = V{2};
end
%% video writing the images


for ii=1:60
   img = b{ii};
   filename = [sprintf('b%03d',ii) '.jpg'];
   fullname = fullfile('C:\Users\Dhruva\Documents\MATLAB\output','images1',filename);
   imwrite(img,fullname);    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
end
imageNames4 = dir(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','images1','b*.jpg'));
imageNames4= {imageNames4.name}';

%% output video 1
Video2 = VideoWriter(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','b.avi'));
Video2.FrameRate = 30;        
open(Video2)
for ii = 1:length(imageNames4)
   img = imread(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','images1',imageNames4{ii}));
   writeVideo(Video2,img);
end

for ii = 1:length(imageNames4)
   img = imread(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','images1',imageNames4{ii}));
   writeVideo(Video2,img)
end

close(Video2)
ii = 1;
while ii<=60
   mov(ii) = im2frame(b{ii});
   ii = ii+1;
end

%% Bandpass filter temporally

obj3 = VideoReader('C:\Users\Dhruva\Documents\MATLAB\output\b.avi');
video3 = obj3.read();

A = ideal_bandpassing(video3,4,2,3,30);
A=20*A;     %Amplifying the bandpassed video

%% Reconstruction
for i=1:3
    for j=1:352
        for k=1:640
            for l=1:120
    B(j,k,i,l) = A(j,k,i,l) + video3(j,k,i,l);      
            end
        end
    end
end

%% Video writing the output video

mkdir('C:\Users\Dhruva\Documents\MATLAB\output','video')
for ii=1:60
   img = B(:,:,:,ii);
   filename = [sprintf('B%03d',ii) '.jpg'];
   fullname = fullfile('C:\Users\Dhruva\Documents\MATLAB\output','video',filename);
   imwrite(img,fullname);    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
end
video = dir(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','video','B*.jpg'));
video= {video.name}';
%% making video
Video2 = VideoWriter(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','last_video.avi'));
Video2.FrameRate = 15;     % Please find the frameRate <<--------------------------------------------------
open(Video2)
for ii = 1:length(video)
   img = imread(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','video',video{ii}));
   writeVideo(Video2,img);
end

for ii = 1:length(video)
   img = imread(fullfile('C:\Users\Dhruva\Documents\MATLAB\output','video',video{ii}));
   writeVideo(Video2,img)
end

close(Video2)
%obj = VideoReader('C:\Users\Dhruva\Documents\MATLAB\output\last_video.avi');
%video = obj.read();
%imtool(video(:,:,:,2));


%for i=1:60
    %    x(:,:,:,i) = video(:,:,:,i);
   %      x1(i) = x(173,315,1,i);     %taking only the red intensity
  %      x2(i) = x(173,316,1,i);
 %       x1(i) = (x1(i)/2) + (x2(i)/2);
%end
    
%plot(x1);

%p = findpeaks(double(x1));
%count = 0;
%M = max(p);

%for i=1:length(p)
  %  if(p(i) > M - 10)
 %       count= count +1;
%    end
%end

%R = randperm(10,1);
%H = count*15 + R;
%fileid=fopen('heart.txt','w');
%fprintf(fileid,'The heartrate is %d.',H);
%fclose(fileid);

