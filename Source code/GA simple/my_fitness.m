  
function y = my_fitness(population)
% population l� m?t ma tr?n c�c s? ng?u nhi�n [0,1]
% thao t�c sau thay �?i ph?m vi th�nh [-1,1]
population = 2 * (population - 0.5); 
y = sum(population.^2, 2); % t�nh t?ng c�c b?nh ph��ng