function plotdata(struct_input_scadas,str_plot_opt)
% function [x_value, y_value] = plotdata(struct_input_scadas,str_plot_opt)
% plot de FRF a partir dos dados experimentais do scadas

% x values

x_value = zeros(1,struct_input_scadas.x_values.number_of_values);
x_value(1) = struct_input_scadas.x_values.start_value;
for i = 2:max(size(x_value))
    x_value(i) = x_value(i-1)+struct_input_scadas.x_values.increment;
end

% y values

y_value = (struct_input_scadas.y_values.values);
fase = 180*(angle(struct_input_scadas.y_values.values))/pi;
% y_value = abs(y_value.*x_value'*2*pi*sqrt(-1)); %derivada
y_value = abs(y_value);
% fase = angle(struct_input_scadas.y_values.values);
% y_value_dB =  mag2db(y_value);


subplot(2,1,2) %Plot fase
hold on
f = plot(x_value,fase,str_plot_opt,'linewidth',2);
% axis label
xlabel(struct_input_scadas.x_values.quantity.label,'fontsize',14)
ylabel 'Phase(deg)'
f.Parent.FontSize = 12;

xlim([90, 150]); % Ajuste de figura
f.Parent.XGrid = 'On';
f.Parent.XMinorTick = 'On';
f.Parent.XTick = 90:5:150;
f.Parent.XMinorGrid = 'On';
f.Parent.YLim = [-200 200];
f.Parent.YTick = [-180 -90 0 90 180];
f.Parent.YGrid = 'On';
f.Parent.YMinorGrid = 'On';
f.Parent.YMinorTick = 'On';
f.Parent.XGrid = 'on';
f.Parent.YGrid = 'on';


subplot(2,1,1) % Plot amplitude

hold on

a = semilogy(x_value,y_value,str_plot_opt,'linewidth',2);

if struct_input_scadas.y_values.quantity.label == 's' % axis label
    ylabel('(m/s)/(m/s^2)','fontsize',14)
else
ylabel(struct_input_scadas.y_values.quantity.label,'fontsize',14)
end
a.Parent.FontSize = 12;


xlim([90, 150]); % axis limits
axis 'auto_y';

% ajuste de figura
a.Parent.XGrid = 'on';
a.Parent.XTick = 90:5:150;
a.Parent.YGrid = 'on';
a.Parent.XMinorTick = 'on';
a.Parent.XMinorGrid = 'on';
a.Parent.YMinorTick = 'on';
a.Parent.YMinorGrid = 'on';
a.Parent.YScale = 'log';
hold off

end
