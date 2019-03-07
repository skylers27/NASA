function Y=get_delay_vector(data,embed_dimen,delta)
    Y = zeros(1,embed_dimen); %initialize array
    for i = 1:embed_dimen
        Y(i) = data(i+delta); %append shifted data
    end
end


