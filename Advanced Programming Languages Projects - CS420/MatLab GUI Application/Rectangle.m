classdef Rectangle < Shape & ColorMixin

    properties

        length
        width

    end 

    methods 
        
        %Constructor for Rectangle
        function obj = Rectangle(shapeName, length, width, newColor)
            obj@Shape(shapeName); %calling superclass to assign a name
            obj@ColorMixin(newColor);%Calls other superclass's constructor
                                      %to fill in circle's color
            obj.length = length;
            obj.width = width;
        end 
        
        %Calculates area of the Rectangle
        function obj = CalculateArea(obj)
            rectangleArea = obj.length * obj.width; %area formula
            obj.Area = round(rectangleArea);
        end
        
        %displays rectangle's properties and color
        function disp(obj)
            disp@Shape(obj); %calls superclass's constructor
            fprintf(['This rectangle is %s with a ' ...
                'length of %d and a width of ' ...
                '%d \n'], obj.color, obj.length, obj.width);%prints new info
        end

        %opens a plot and draws the rectangle
        function draw(obj)
            title('Drawing of a Rectangle');
            pos = [obj.length, obj.width, obj.length, obj.width];
            rectangle('Position', pos,'FaceColor', obj.color, ...
            'LineWidth', 3);
            axis equal;
            str = sprintf(['Length: %f, \n Width: %f, Area: %f \n' ...
                'Color: %s'], ...
                obj.length, obj.width, obj.Area, obj.color);            
            text(obj.length + 3.25, obj.width + 3.25, str, ...
                'BackgroundColor','white', 'FontSize',12, ...
                'HorizontalAlignment','left');
        end

    end


end