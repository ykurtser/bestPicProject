function [ i ] = IndexOfClosestValue( val, Arr )
%Returns the index of the element in Arr which Value is closest to val

MinVal = 999999;
MinIndex = 0;
for n=1:length(Arr)
    TempVal = abs(Arr(n)-val);
    if (TempVal == 0)
        MinVal = TempVal;
        MinIndex = n;
        break
    end
    if (TempVal<MinVal)
        MinVal = TempVal;
        MinIndex = n;
    end
end
i = MinIndex;

