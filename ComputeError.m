function [ ErrorTime, ErrorData ] = ComputeError( TimeTrue, DataTrue, TimeCompare, DataCompare )

IntErrIndex = 2;
ErrIndex = 0;
for j=1:length(TimeCompare)
    for k=IntErrIndex:length(TimeTrue)
        if(TimeTrue(k) > TimeCompare(j))
            IntErrIndex = k;
            ErrIndex = ErrIndex+1;
            ErrorTime(ErrIndex) = (TimeCompare(j) + TimeTrue(k))/2;
            slope = (DataTrue(k) - DataTrue(k-1)) / (TimeTrue(k) - TimeTrue(k-1));
            intercept = DataTrue(k) - (slope*TimeTrue(k));
            Truth = (TimeCompare(j)*slope) + intercept;
            ErrorData(ErrIndex) = Truth - DataCompare(j);
            if(ErrorData(ErrIndex) >= 180)
                ErrorData(ErrIndex) = ErrorData(ErrIndex) - 360;
            elseif(ErrorData(ErrIndex) <= -180)
                ErrorData(ErrIndex) = ErrorData(ErrIndex) + 360;
            end
            break;
        end
    end
end
