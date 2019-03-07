function [C] = get_correlation_integral(data, dimension, delay)

N = length(data); %get number of points
accumulate = 0;
for i = 1:N-delay-1
   for j=i+1:N-delay-1
       %if above threshold, add 1 to accumulate
       if dimension-euclidian_distance(get_delay_vector(data(i:end),2,delay),get_delay_vector(data(j:end),2,delay)) > 0
           accumulate = accumulate + 1;
       end
   end
end
C = 2/(N*(N-1))*accumulate; %output
end
