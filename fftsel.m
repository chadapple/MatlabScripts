function fftsel()

% Get region from user
[Time,Data]=ginput(2);
CurrentAxis = gca();
Lines = CurrentAxis.Children;
LinesArray = {};
% Extract the display names (MUST HAVE A LEGEND WITH A NAME ASSOCIATED WITH EACH SIGNAL!)
for i=1:length(Lines)
    SignalName = cellstr(Lines(i).DisplayName);
    if(strcmp(SignalName, '') == 1)
        errordlg('Signals must be named in a legend');
        return;
    end
    LinesArray(i) = SignalName;
end

CurrentFigure = gcf();
% Create a prompt with a drop down box of signal names
f = figure;
set(f, 'MenuBar', 'none');
set(f, 'ToolBar', 'none');
set(f, 'Position', [(CurrentFigure.Position(1) + CurrentFigure.Position(3)/2) ...
                 (CurrentFigure.Position(2) + CurrentFigure.Position(4)/2) ...
                 260 50]);
pm = uicontrol(f,'Style','popupmenu',...
                'String',LinesArray,...
                'Value',1,'Position',...
                [20 20 150 20]);
pb = uicontrol(f,'Style','pushbutton','String','Select','Callback',@pushbutton1_Callback,...
                'Position',[200 20 40 20]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Button has been pressed, initiate the FFT analysis
    function pushbutton1_Callback(hObject, eventdata, handles)
        items = get(pm,'String');
        index_selected = get(pm,'Value');
        item_selected = items{index_selected};
        for i=1:length(Lines)
            if(strcmp(cellstr(Lines(i).DisplayName), item_selected) == 1)
                StartIndex = find(Lines(i).XData < Time(1), 1, 'last');
                EndIndex = find(Lines(i).XData > Time(2), 1, 'first');
                Range = StartIndex:EndIndex;
                close(gcf);
                performFFT(Lines(i).XData(Range), Lines(i).YData(Range));
%                 figure;
%                 plot(Lines(i).XData(Range), Lines(i).YData(Range));
            end
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function performFFT(Time, Data)
        [ fftTarget, fftFreqArray ] = calcFFT( Data, 1/mean(diff(Time)) );
        fftLength2 = round(length(fftTarget)/2);
        figure;
        plot(fftFreqArray(1:fftLength2),abs(fftTarget(1:fftLength2)));
        xlabel('Frequency (Hz)');
        ylabel('FFT Component Breakdown');
        grid on;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FFT analysis
    function [ fftTarget, fftFreqArray ] = calcFFT( InputData, SampleFreq )
        DataLength = length(InputData);
        fftTarget = fft(InputData);

        fftLength = length(fftTarget);

        % Normalize fft's
        fftTarget = (fftLength/DataLength)*2*fftTarget/fftLength;

        % Calculate frequency array
        fftFreqArray  = SampleFreq*(0:fftLength-1)/fftLength;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
