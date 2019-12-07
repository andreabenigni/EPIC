function c=mpower(a,b)

    if strcmp(class(b),'double')
        c=a;
        for x=2:b
            c=c*a ;
        end
    else
        error('Power operation x^a with a of type PCT not supported')
    end
end
