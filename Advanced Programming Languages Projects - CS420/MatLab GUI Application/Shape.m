classdef Shape < matlab.mixin.Heterogeneous

    properties 
        
        Name = "Null"
        Area = []

    end 

    methods

        function obj = Shape(shapeName) %constructor
        %to make sure there is at least one arguement
        if nargin > 0 
           obj.Name = shapeName;
           obj.Area = [];
        else
           error('Invalid: Shape does not have a name');
        end
     end
    %function to display the obj's name and area
     function disp(obj)
         fprintf('Shape Name: %s\n', obj.Name);
         fprintf('Shape Area: %f\n', obj.Area);
     end 

    end
    %function to calculate mean, median, & standard dev of an array 
    %of objects
    methods (Static)
        function CalculateStatistics(array)
            fprintf('Mean Area: %d \n', round(mean([array.Area])) );
            fprintf('Median Area: %d \n', round(median([array.Area])) );
            fprintf(['Standard Deviation ' ...
                'of Areas: %d \n'], round(std([array.Area])) );
        end 
    end 
end