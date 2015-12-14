
obj = VideoReader('subject16.mp4');
video = obj.read();
detectface=vision.CascadeObjectDetector;
for j=1:1
    
    I=video(:,:,:,j);
    BOX=step(detectface,I);
    figure;
    imshow(I);
    hold on
    for i=1:size(BOX,1)
      rectangle('position',BOX(i,:),'Linewidth',5,'LineStyle','-','EdgeColor','r');
    end
    title('Face detection');
    hold off;
end


x_b = BOX(1)+ 0.75*BOX(3);
y_b = BOX(2) + 0.5*BOX(4);
