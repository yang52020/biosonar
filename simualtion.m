clear all;
clc;
close all;

signal=load('sonicsignal.mat');
signal=signal.signal;
generated=rand(size(signal))+signal;
shapes=size(signal);
result=zeros(shapes(1)*shapes(2)*shapes(3)*shapes(4)*shapes(5),shapes(6)*2*3);
templates=zeros(544500,512*3);
counter=0;

    for j=1:shapes(4)% 10 repetition
        for k=1:shapes(3) %11 angles
            for l=1:shapes(2)%25 position
                
             for p=1:shapes(1) %66 views
                 counter=counter+1;
                 %counstruct templates
               templates(counter,:)=[signalprocessing(signal(p,l,k,j,1,:)),signalprocessing(signal(p,l,k,j,2,:)),signalprocessing(signal(p,l,k,j,3,:))];
                  %summation equals to 1
               templates(counter,:)=templates(counter,:)/sum(templates(counter,:));
               %result(counter,:)=templates(counter,:)+rand(1,512*3);
               
             end 
              
            end
        end
    end

%% plot spectrogram
spectrogram(templates(1,:),hamming(4),2,4,25000,'yaxis');
%% calculate distance
correct=0;
distance=zeros(counter,counter);
location=zeros(counter,1);
for o=1:counter
    for p=1:counter
        %calculate distance
        distance(o,p)=(templates(p,:)-templates(o,:))*eye(512*3)*(templates(p,:)-templates(o,:))';
    end
    [M,location(o)]=min(distance(o,:),[],2);
    %calcualte threshold to add new templates
    threshold=sqrt(sum(distance(o,:).^2)/length(distance(o,:)))*0.5;
    plot(distance(1,1:counter-1))
    hold on
    label=0;
    for p=1:counter
        % new templates
        if(distance(o,p))>threshold
        plot(p,distance(o,p),'rx')
        label=label+1;
        hold on 
        end
    end
    if(location(o)==o)
        correct=correct+1;
    end
end
