classdef Circle < Shape & ColorMixin

    properties

        radius 
         
    end 

    methods 
        %Circle's constructor
        function obj = Circle(newName, radius, newColor)
            obj@Shape(newName); %calling superclass to assign a name
            obj@ColorMixin(newColor); %Calls other superclass's constructor
                                      %to fill in circle's color
            obj.radius = radius;
        end 
        
        %Function to calc area of circle
        function obj = CalculateArea(obj)
            circleArea = pi * obj.radius^2; %area formula
            obj.Area = round(circleArea);
        end
        
        %displays circle
        function disp(obj)
            disp@Shape(obj); %calls superclass's version for disp
            fprintf(['This circle is %s with a ' ...
                'radius of %d\n'], obj.color, obj.radius); %prints new info
        end
        
        %opens a plot and draws the circle created
        function draw(obj) 
            title('Drawing of a Circle');
            %constructs le circle
            viscircles([obj.radius, obj.radius], ...
                obj.radius, 'Color', obj.color);
            %position of where circle should be
            pos = [0, 0, ...
                (2 * obj.radius), (2 * obj.radius)];

            
            rectangle('Position',pos , ...
                'Curvature', [1,1], ...
                'FaceColor', obj.color);
            axis equal;
            str = sprintf('Radius: %f, Area: %f, \n Color: %s', ...
                obj.radius, obj.Area, obj.color);            
            text(obj.radius + 4.5, obj.radius + 2, str, ...
                'BackgroundColor','white', 'FontSize',12, ...
                'HorizontalAlignment','center');
        end

    end

end