function piecewiseplot
    x = [-1:0.1:1];
    for i = 1:numel(x)
        if x(i) < 0
            h(i) = x(i).^2+1;
        else
            h(i) = x(i);
        end   
    end  
    plot(x,h)
    xlabel('x');
    ylabel('h(x)');
    title('Piecewise function graph');


    