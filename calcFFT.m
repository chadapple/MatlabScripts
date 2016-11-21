function [ fftTarget, fftFreqArray ] = calcFFT( InputData, SampleFreq )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DataLength = length(InputData);
fftTarget = fft(InputData);

fftLength = length(fftTarget);
fftLength2 = round(fftLength/2);

% Normalize fft's to degrees
fftTarget = (fftLength/DataLength)*2*fftTarget/fftLength;

% Calculate frequency array
fftFreqArray  = SampleFreq*(0:fftLength-1)/fftLength;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure;
% plot(fftFreqArray(1:fftLength2),abs(fftTarget(1:fftLength2)));
% xlabel('Frequency (Hz)');
% ylabel('FFT Component Breakdown');
% grid on;

end

