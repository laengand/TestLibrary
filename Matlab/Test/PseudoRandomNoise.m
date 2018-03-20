function timeSignal = PseudoRandomNoise(size, seed)
    %% PseudoRandomNoise
    % PseudoRandomNoise(size, seed) generates Pseudo Random Noise with the
    % length of size using seed as input to the random number generator
    spectrum = ones(1, size/2)/(size/2);
    oldSeed = rng(seed);
    
    randomNum = rand(1, size/2-1)*2*pi;
    z = complex(spectrum(2:end).*cos(randomNum), spectrum(2:end).*sin(randomNum));
    z = [0 z 0 conj(z(end:-1:1))];
    
    timeSignal = ifft(z);
    timeSignal = timeSignal/max(abs(timeSignal));
    
    rng(oldSeed) % restore the previous seed
end

