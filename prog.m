%%Prompting the user to enter the number of cars on the road
num_of_cars_1=input('Number of cars on road 1:');
num_of_cars_2=input('Number of cars on road 2:');










%%Storing the number of cars on the road in a cell array
num_of_cars{1,1}='Road 1';
num_of_cars{1,2}='Road 2';
num_of_cars{2,1}=num_of_cars_1;
num_of_cars{2,2}=num_of_cars_2;

%%Declaring the variable for calculating the frequency for plotting
velocity=1350;



% Initialize the previous output_value
prev_output_value = '';





%%A loop for determining which traffic light/s to be turned off/on
for T=1:length(num_of_cars_1)





%%Calculating the frequency (regular and angular)
frequency1(T)=velocity./(100.*(1./num_of_cars_1(T)));
frequency2(T)=velocity./(100.*(1./num_of_cars_2(T)));
angular_frequency(T)=2*pi*(frequency1(T)+frequency2(T));


%%Finding the sine function
syms t;
f=sin(angular_frequency(T)*t);
fprintf('\n\n\n\n\nThe sine function of time %d is ',T)
sine_function(T)=diff(f,t)
fprintf('\n')
sine_function_plot(T)=angular_frequency(T)*cos(angular_frequency(T)*T);


%%This variable "value" will be used in the switch condition. When value is 0 it represents that road 1 has more cars than road 2,
%%AND when value is 1 it represents that road 2 has more cars than road 1
value=(num_of_cars_2(T)>num_of_cars_1(T));




%%If both roads DON'T have cars
if num_of_cars_1(T)==0 && num_of_cars_2(T)==0

  fprintf("TIME:%d",T)
  disp("[RED]")
  output_value='RED';

% Checks if there was a change between the number of cars on time t and t-1
        if(T ~= 1)
            if ~strcmp(output_value, prev_output_value)
                fprintf("\nTraffic light UPDATED\n")
            end
        end
    end


%%If one of the roads have cars (i.e if either road 1 or road 2 have cars BUT NOT BOTH!)
if num_of_cars_1(T)>0 || num_of_cars_2(T)>0


  if num_of_cars_2(T)==0

    fprintf("TIME:%d",T)
    disp("[GREEN road 1, RED road 2]")
    output_value='GREEN road 1, RED road 2';

% Checks if there was a change between the number of cars on time t and t-1
            if(T ~= 1)
                if ~strcmp(output_value, prev_output_value)
                    fprintf("\nTraffic light UPDATED\n")
                end
            end
        end

  if num_of_cars_1(T)==0

    fprintf("TIME:%d",T)
    disp("[RED road 1, GREEN road 2]")
    output_value='RED road 1, GREEN road 2';

% Checks if there was a change between the number of cars on time t and t-1
            if(T ~= 1)
                if ~strcmp(output_value, prev_output_value)
                    fprintf("\nTraffic light UPDATED\n")
                end
            end
        end
    end


%%If both roads have cars
if num_of_cars_1(T)>0 && num_of_cars_2(T)>0

  switch value
    %%Road 1 has more cars
  case 0

    fprintf("TIME:%d",T)
      disp("[GREEN road 1, RED road 2]")
      output_value='GREEN road 1, RED road 2';

% Checks if there was a change between the number of cars on time t and t-1
                if(T ~= 1)
                    if ~strcmp(output_value, prev_output_value)
                        fprintf("\nTraffic light UPDATED\n")
                    end
                end

    %%Road 2 has more cars
  case 1

      fprintf("TIME:%d",T)
      disp("[RED road 1, GREEN road 2]")
      output_value='RED road 1, GREEN road 2';

% Checks if there was a change between the number of cars on time t and t-1
                if(T ~= 1)
                    if ~strcmp(output_value, prev_output_value)
                        fprintf("\nTraffic light UPDATED\n")
                    end
                end

    otherwise
      disp("UNEXECPTED ERROR!")
    end

end





end




% Update prev_output_value at the end of the loop
prev_output_value = output_value;








%%Declaring the useless variables 'x' so that we can see the frequency plot itself (i.e ezplot() function)
x=linspace(0,max(sine_function_plot),length(sine_function_plot));
x1=linspace(0,max(frequency1),length(frequency1));
x2=linspace(0,max(frequency2),length(frequency2));

plot3(x,sine_function_plot,x),ylabel('Sine Function'), legend('Sine function with respect to time'),grid on

figure

subplot(1,2,1)
plot(x1,frequency1),ylabel('Frequency (Hz)'),legend('Road 1 frequency'), grid on, hold

subplot(1,2,2)
plot(x2,frequency2),ylabel('Frequency (Hz)'),legend('Road 2 frequency'), grid on










%%Writing to an excel file
xlswrite('myXlFile.xlsx',num_of_cars{2,1});
xlswrite('myXlFile.xlsx',num_of_cars{2,2});

msgbox('The number of cars on the road has been written to an Excel file','Write operation')
