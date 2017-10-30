function [cin, constraints] = kinematicWrapper(x)
global controlIndex nx nu K xStart
    constraints = zeros(nx*K,1);
    constraints(1:nx) = x(1:nx) - xStart;
    for i=1:K-1
        xNow = x(nx*(i-1)+1:nx*i);
        uNow = x(controlIndex+nu*(i-1):nu*i+controlIndex-1);
        constraints(nx*i+1:nx*(i+1)) = x(nx*i+1:nx*(i+1)) - kinematics(xNow, uNow);
    end
    
    cin = [];
end

function xNew = kinematics(x,u)
global deltaT
xNew = zeros(3,1);
xNew(1) = u(1)*cos(x(3))*deltaT + x(1);
xNew(2) = u(1)*sin(x(3))*deltaT + x(2);
xNew(3) = x(3) + u(2)*deltaT;
end


