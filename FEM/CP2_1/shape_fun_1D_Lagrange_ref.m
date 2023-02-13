function f = shape_fun_1D_Lagrange_ref(t, shape_index, d_index,degree)
if degree == 0
    if shape_index == 1
        if d_index == 0
            f = ones(size(t));
        elseif d_index > 0
            f = zeros(size(t));
        end
    else
        disp(['shape_index = ', int2str(shape_index)])
        disp('This program is not for this value of shape_index')
        disp('Terminate this program by Ctrl+C')
        pause
    end
elseif degree == 1
    if shape_index == 1
        if d_index == 0
            f = (1-t)/2;
        elseif d_index == 1
            f = (-1/2)*ones(size(t));
        elseif d_index > 1
            f = zeros(size(t));
        end
    elseif shape_index == 2
        if d_index == 0
            f = (1+t)/2;
        elseif d_index == 1
            f = (1/2)*ones(size(t));
        elseif d_index > 1
            f = zeros(size(t));
        end
    else
        disp(['shape_index = ', int2str(shape_index)])
        disp('This program is not for this value of shape_index')
        disp('Terminate this program by Ctrl+C')
        pause
    end
elseif degree == 2
    if shape_index == 1
        if d_index == 0
            f = -(1/2)*(1-t).*t;
        elseif d_index == 1
            f = -1/2+t;
        elseif d_index == 2
            f = ones(size(t));
        elseif d_index > 2
            f = zeros(size(t));
        end
    elseif shape_index == 2
        if d_index == 0
            f = 1-t.^2;
        elseif d_index == 1
            f = -2*t;
        elseif d_index == 2
            f = -2*ones(size(t));
        elseif d_index > 2
            f = zeros(size(t));
        end
    elseif shape_index == 3
        if d_index == 0
            f = (1/2)*t.*(1+t);
        elseif d_index == 1
            f = 1/2 + t;
        elseif d_index == 2
            f = ones(size(t));
        elseif d_index > 2
            f = zeros(size(t));
        end
    else
        disp(['shape_index = ', int2str(shape_index)])
        disp('This program is not for this value of shape_index')
        disp('Terminate this program by Ctrl+C')
        pause
    end
% degree = 3 added by WH
elseif degree == 3
    if shape_index == 1
        if d_index == 0
            f = -(9*(t - 1).*(t - 1/3).*(t + 1/3))/16;
        elseif d_index == 1
            f = - (9*(t - 1).*(t - 1/3))/16 - (9*(t - 1).*(t + 1/3))/16 - (9*(t - 1/3).*(t + 1/3))/16;
        elseif d_index == 2
            f = 9/8 - (27*t)/8;
        elseif d_index == 3
            f = -27/8*ones(size(t));
        elseif d_index > 3
            f = zeros(size(t));
        end
    elseif shape_index == 2
        if d_index == 0
            f = (27*(t - 1).*(t + 1).*(t - 1/3))/16;
        elseif d_index == 1
            f = (27*(t - 1).*(t + 1))/16 + (27*(t - 1).*(t - 1/3))/16 + (27*(t + 1).*(t - 1/3))/16;
        elseif d_index == 2
            f = (81*t)/8 - 9/8;
        elseif d_index == 3
            f = 81/8*ones(size(t));    
        elseif d_index > 3
            f = zeros(size(t));
        end
    elseif shape_index == 3
        if d_index == 0
            f = -(27*(t - 1).*(t + 1).*(t + 1/3))/16;
        elseif d_index == 1
            f = - (27*(t - 1).*(t + 1))/16 - (27*(t - 1).*(t + 1/3))/16 - (27*(t + 1).*(t + 1/3))/16;
        elseif d_index == 2
            f = - (81*t)/8 - 9/8;
        elseif d_index == 3
            f = - 81/8*ones(size(t));    
        elseif d_index > 3
            f = zeros(size(t));
        end
    elseif shape_index == 4
        if d_index == 0
            f = (9*(t + 1).*(t - 1/3).*(t + 1/3))/16;
        elseif d_index == 1
            f = (9*(t + 1).*(t - 1/3))/16 + (9*(t + 1).*(t + 1/3))/16 + (9*(t - 1/3).*(t + 1/3))/16;
        elseif d_index == 2
            f = (27*t)/8 + 9/8;
        elseif d_index == 3
            f = 27/8*ones(size(t)); 
        elseif d_index > 3
            f = zeros(size(t));
        end
    else
        disp(['shape_index = ', int2str(shape_index)])
        disp('This program is not for this value of shape_index')
        disp('Terminate this program by Ctrl+C')
        pause
    end 
%
elseif degree > 3
    disp(['degree = ', int2str(degree)])
    disp('This program is not for this value of degree')
    disp('Terminate this program by Ctrl+C')
    pause
end

