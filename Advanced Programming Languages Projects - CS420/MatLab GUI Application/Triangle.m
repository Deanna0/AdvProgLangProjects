classdef Triangle < Shape & ColorMixin

    properties

        base
        height

    end 

    methods 
        %Triangle's constructor
        function obj = Triangle(shapeName, b, h, newColor)
            obj@Shape(shapeName);%calling superclass to assign a name
            obj@ColorMixin(newColor);%Calls other superclass's constructor
                                      %to fill in circle's color
            obj.base = b;
            obj.height = h;
        end 
        
        %calculates area for a triangle
        function obj = CalculateArea(obj)
            rectangleArea = .5 * obj.base * obj.height; %area formula
            obj.Area = round(rectangleArea);
        end

        %displays triangle's properties
        function disp(obj)
            disp@Shape(obj);
            fprintf(['This triangle is %s with a base of %d and' ...
                'a height of %d'], obj.color, obj.base, obj.height);  
        end
        
        %opens a plot to draw the triangle
        function draw(obj)
            %position of how triangle should be formed
            x = [0 obj.base/2 obj.base];
            y = [0 obj.height 0];
            title('Drawing of a Triangle');
            plot(x,y, 'Color', obj.color);
            axis equal;
            fill(x,y, obj.color); % fills triangle with color
            str = sprintf(['Height: %f, \n Base: %f, Area: %f, \n' ...
                'Color: %s'], ...
                obj.height, obj.base, obj.Area, obj.color);            
            text((obj.base/2), (obj.height/2 - 1), str, ...
                'BackgroundColor','white', 'FontSize',14, ...
                'HorizontalAlignment','center');
        end 
     
    end


end