function result=signalprocessing(signal)
grammatonefilter=gammatonebank(50000);
result=0;
if(size(signal,1)==1)
    for i=1:size(grammatonefilter,1)
    a=conv(grammatonefilter(i,:),reshape(signal,1,256));%gammatonefilter
    a(a<0)=0;%half rectification
    filteredsignal=lowpass(a,200,25000);%low passfilter
    result=result+filteredsignal;
    end
    
else
   for i=1:size(grammatonefilter,1)
    a=conv(grammatonefilter(i,:),reshape(signal,1,256));
    a(a<0)=0;
    filteredsignal=lowpass(a,200,25000);
    result=result+filteredsignal;
   end
    
end
