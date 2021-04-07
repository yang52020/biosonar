function response=gammatonebank(stepsize)
t=[0:1/25000:256/25000];% sampling rate 25000
bandwidth=5;
samplingrate=1/25000;
counter=0;
for i=1:100
    if(exp(i)>=29&&exp(i)<45000)%% in exponential range frequency swing
       bandwidth=25+exp(i)/20;
       counter=counter+1;
      response(counter,:)=t.^3.*exp(-2*pi*bandwidth*t).*cos(2*pi*exp(i)*t);
    else
    end
end