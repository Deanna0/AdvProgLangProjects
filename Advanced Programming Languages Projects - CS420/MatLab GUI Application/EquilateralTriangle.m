classdef EquilateralTriangle < Triangle & ColorMixin
    
    properties
        
        sideLength

    end
    
    methods
    
        function obj = EquilateralTriangle(shapeName, s, newColor)
            height = s * sqrt(3) * 0.5; % calculates height ... 
                                        % ... for constructor
            obj@Triangle(shapeName, s, height, newColor);
            obj@ColorMixin(newColor);
            obj.sideLength = s;
        end 

        function disp(obj)
            disp@Shape(obj);
            fprintf(['This equilateral triangle is %s with' ...
                'a sidelength of %d \n'], obj.color, obj.sideLength);
        end 

    end

end