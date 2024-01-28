function MyShapes
   

    
    while true
        disp('Select a shape to create:');
        disp('1. Circle');
        disp('2. Rectangle');
        disp('3. Triangle');
        disp('4. Quit');
        choice = input('Enter your choice (1/2/3/4): ');

        if choice == 1
            name = input('Enter the name of the circle: ');
            radius = input('Enter the radius of the circle: ');
            color = input('Enter the color of the shape: ');
            a = Circle(name, radius, color);
            a = CalculateArea(a);
            %theta = linspace(0,2*pi);
            %x = a.radius*cos(theta) + (a.radius * 2);
            %y = a.radius*sin(theta) + (a.radius * 2);
            %plot(x,y)
            close all;
            draw(a);  
        elseif choice == 2
            name = input('Enter the name of the rectangle: ');
            width = input('Enter the width of the rectangle: ');
            height = input('Enter the height of the rectangle: ');
            color = input('Enter the color of the shape: ');
            b = Rectangle(name, width, height, color);
            b = CalculateArea(b);
            %x = b.width;
            %y = b.length;
            %rectangle('Position',[1 1 x y])
            axis([-10 10 -10 10])
            draw(b);
        elseif choice == 3
            name = input('Enter the name of the triangle: ');
            base = input('Enter the base of the triangle: ');
            height = input('Enter the height of the triangle: ');
            color = input('Enter the color of the shape: ');
            c = Triangle(name, base, height, color);
            c = CalculateArea(c);
            %TRIANGLE PLOTTING GOES HERE
            draw(c);
        elseif choice == 4
            disp('Goodbye!');
            break;
        else
            disp('Invalid choice. Please select a valid option.');
        end
        
    end
end
