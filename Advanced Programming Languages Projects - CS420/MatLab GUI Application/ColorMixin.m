classdef ColorMixin
    properties
        
        color

    end

    methods

        function obj = ColorMixin(c)
            obj.color = c;
        end

        function value = get.color(obj)
            value = obj.color;
        end 

        function obj = set.color(obj, newColor)
            obj.color = newColor;
        end
    end
end