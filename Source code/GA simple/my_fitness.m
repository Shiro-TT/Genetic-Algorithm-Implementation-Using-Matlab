  
function y = my_fitness(population)
% population là m?t ma tr?n các s? ng?u nhiên [0,1]
% thao tác sau thay ð?i ph?m vi thành [-1,1]
population = 2 * (population - 0.5); 
y = sum(population.^2, 2); % tính t?ng các b?nh phýõng