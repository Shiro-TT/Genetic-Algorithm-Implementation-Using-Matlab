function [best_fitness, elite, generation, last_generation] = my_ga( ...
    number_of_variables, ...    % s? l�?ng tham s? �? gi?i quy?t v?n �?
    fitness_function, ...       % t�n ch?c n�ng th? d?c tu? ch?nh
    population_size, ...        % k�ch th�?c qu?n th? (s? l�?ng c� th? ? m?i th? h?)
    parent_number, ...          % s? l�?ng kh�ng �?i ? m?i th? h? (ngo?i tr? �?t bi?n)
    mutation_rate, ...          % x�c su?t �?t bi?n
    maximal_generation, ...     % ti?n ho� t?i �a
    minimal_cost ...            % gi� tr? m?c ti�u t?i thi?u (gi� tr? h�m c�ng nh?, �? ph� h?p c�ng cao)
)

% X�c su?t t�ch l?y
% Gi? s? parent_number = 10
% Numerator parent_number: -1: 1 ��?c s? d?ng �? t?o m?t chu?i s?
% Denominator sum (parent_number: -1: 1) l� m?t k?t qu? t?ng (m?t s?)
%
% Ph�n t? 10 9 8 7 6 5 4 3 2 1
% M?u s? 55
% Chia cho 0,1818 0,1636 0,1455 0,1273 0,1091 0,0909 0,0727 0,0545 0,0364 0,0182
% T�ch l?y 0,1818 0,3455 0,4909 0,6182 0,7273 0,8182 0,8909 0,9455 0,9818 1,0000
%
% K?t qu? ho?t �?ng c� th? ��?c nh?n th?y
% H�m x�c su?t t�ch l?y l� m?t h�m ph�t tri?n ch?m t? 0 �?n 1
% V? x�c su?t th�m v�o sau ng�y c�ng nh? (d?y s? ��?c s?p x?p theo th? t? ?o gi?m d?n)
cumulative_probabilities = cumsum((parent_number:-1:1) / sum(parent_number:-1:1)); % 1 d?y s? c� �? d�i l� parent_number

% Th? l?c t?t nh?t
% Th? l?c t?t nh?t c?a m?i th? h? l?n �?u ti�n ��?c kh?i t?o th�nh 1
best_fitness = ones(maximal_generation, 1);

% �u t�
% C�c gi� tr? tham s? c?a gi?i �u t� c?a m?i th? h? l?n �?u ti�n ��?c kh?i t?o th�nh 0
elite = zeros(maximal_generation, number_of_variables);

% S? l�?ng con
% Quy m� d�n s? - s? l�?ng b? m? (b? m? l� nh?ng c� th? kh�ng thay �?i trong m?i th? h?)
child_number = population_size - parent_number; % s? con trong m?i th? h?

% D�n s? ban �?u
% population_size t��ng ?ng v?i c�c h�ng c?a ma tr?n, m?i h�ng �?i di?n cho 1 c� th?, s? h�ng = s? l�?ng c� th? (s? qu?n th?)
% number_of_variables  t��ng ?ng v?i c�c c?t c?a ma tr?n, s? c?t = s? l�?ng tham s? (c�c �?c �i?m ri�ng l? ��?c bi?u th? b?ng c�c tham s? n�y)
population = rand(population_size, number_of_variables);

last_generation = 0; % ghi l?i th? h? khi ra kh?i v?ng l?p

% Ph?n ti?p theo l� m?t v?ng l?p for
for generation = 1 : maximal_generation 
    
    % feval ��a d? li?u v�o m?t h�m x? l? �? x�c �?nh �? t�nh to�n
    % ��a ma tr?n population v�o h�m fitness_function
    cost = feval(fitness_function, population); % T�nh to�n th? l?c cho t?t c? c�c c� th??population_size *1?

    % index ghi l?i s? h�ng ban �?u cho m?i gi� tr? sau khi s?p x?p
    [cost, index] = sort(cost); % S?p x?p c�c gi� tr? c?a h�m th? d?c t? nh? �?n l?n

    % index(1:parent_number) 
    % S? h�ng c?a population c?a c�c c� th? parent_number �?u ti�n v?i cost th?p h�n
    % Ch?n ph?n (parent_number) nh� cha m?, parent_number t��ng ?ng v?i c�c x�c su?t ch�o
    population = population(index(1:parent_number), :); % Gi? m?t v�i c� th? v�?t tr?i h�n
    % C� th? th?y ma tr�n population li�n t?c thay �?i

    % cost sau l?n s?p x?p sort tr�?c, ma tr?n �? ��?c thay �?i th�nh th? t? t�ng d?n
    % cost(1) l� th? l?c t?t nh?t cho th? h? n�y
    best_fitness(generation) = cost(1); % Ghi l?i th? l?c t?t nh?t c?a th? h? n�y

    % D?ng �?u ti�n c?a ma tr?n population l� nh?ng c� th? �u t� c?a th? h? n�y
    elite(generation, :) = population(1, :); % Ghi l?i gi?i ph�p t?i �u c?a th? h? n�y (�u t�)

    % N?u gi?i ph�p t?i �u c?a th? h? n�y �? t?t, d?ng s? ph�t tri?n
    if best_fitness(generation) < minimal_cost 
        last_generation = generation;
        break; 
    end
    
    % �?t bi?n ch�o t?o ra m?t qu?n th? m?i

    % B?t �?u qua l?i nhi?m s?c th?
    for child = 1:2:child_number % K�ch th�?c b�?c l� 2 v? m?i l?n t�i t? h?p s? t?o ra 2 con
        
        % �? d�i c?a cumulative_probabilities l� parent_number
        % Ch?n ng?u nhi�n 2 cha m? t? n�  (child+parent_number)%parent_number
        mother = find(cumulative_probabilities > rand, 1); % Ch?n m? t?t h�n
        father = find(cumulative_probabilities > rand, 1); % Ch?n cha t?t h�n
        
        % ceil?gi� tr? tr?n?l�m tr?n
        % rand kh?i t?o m?t s? ng?u nhi�n
        % Ch?n ng?u nhi�n m?t c?t, gi� tr? c?t n�y b? thay �?i
        crossover_point = ceil(rand*number_of_variables); % x�c �?nh ng?u nhi�n s? trao �?i c?a nhi?m s?c th?
        
        % N?u crossover_point = 3, number_of_variables = 5
        % mask1 = 1     1     1     0     0
        % mask2 = 0     0     0     1     1
        mask1 = [ones(1, crossover_point), zeros(1, number_of_variables - crossover_point)];
        mask2 = not(mask1);
        
        % Nh?n 4 nhi?m s?c th? ri�ng bi?t
        % Ch� ? l�. *
        mother_1 = mask1 .* population(mother, :); % Ph?n tr�?c c?a nhi?m s?c th? m?
        mother_2 = mask2 .* population(mother, :); % Ph?n sau c?a nhi?m s?c th? m?
        
        father_1 = mask1 .* population(father, :); % Ph?n tr�?c c?a nhi?m s?c th? cha
        father_2 = mask2 .* population(father, :); % Ph?n sau c?a nhi?m s?c th? cha
        
        % Nh?n th? h? ti?p theo
        population(parent_number + child, :) = mother_1 + father_2; % m?t c� th? con
        population(parent_number+child+1, :) = mother_2 + father_1; % m?t c� th? con kh�c
        
    end % K?t th�c c?a trao �?i nhi?m s?n th?
    
    
    % Bi?n th? nhi?m s?c th? b?t �?u
    
    % D�n s? bi?n th?
    mutation_population = population(2:population_size, :); % C�c c� th? �u t� kh�ng tham gia v�o �?t bi?n, v? v?y b?t �?u t? 2
    
    number_of_elements = (population_size - 1) * number_of_variables; % s? l�?ng t?t c? c�c gen
    number_of_mutations = ceil(number_of_elements * mutation_rate); % S? l�?ng �?t bi?n (t?ng s? gen * t? l? �?t bi?n)
    
    % rand(1, number_of_mutations) T?o ma tr?n g?m c�c s? ng?u nhi�n number_of_mutations(ph?m vi 0-1)(1*number_of_mutations)
    % Sau khi nh�n, m?i ph?n t? c?a ma tr?n �?i di?n cho v? tr� c?a gen thay �?i (t?a �? m?t chi?u c?a ph?n t? trong ma tr?n)

    mutation_points = ceil(number_of_elements * rand(1, number_of_mutations)); % x�c �?nh gen b? �?t bi?n
    
    % C�c gen �? ch?n ��?c thay th? b?ng m?t s? ng?u nhi�n �? ho�n th�nh �?t bi?n
    mutation_population(mutation_points) = rand(1, number_of_mutations); % Th?c hi?n c�c thao t�c g�y �?t bi?n tr�n c�c gen �? ch?n
    
    population(2:population_size, :) = mutation_population; % D�n s? sau khi �?t bi?n
    
    % K?t th�c c?a s? bi?n �?i nhi?m s?c th?
   
end % K?t th�c chu k? ti?n ho�
