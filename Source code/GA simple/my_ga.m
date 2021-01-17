function [best_fitness, elite, generation, last_generation] = my_ga( ...
    number_of_variables, ...    % s? lý?ng tham s? ð? gi?i quy?t v?n ð?
    fitness_function, ...       % tên ch?c nãng th? d?c tu? ch?nh
    population_size, ...        % kích thý?c qu?n th? (s? lý?ng cá th? ? m?i th? h?)
    parent_number, ...          % s? lý?ng không ð?i ? m?i th? h? (ngo?i tr? ð?t bi?n)
    mutation_rate, ...          % xác su?t ð?t bi?n
    maximal_generation, ...     % ti?n hoá t?i ða
    minimal_cost ...            % giá tr? m?c tiêu t?i thi?u (giá tr? hàm càng nh?, ð? phù h?p càng cao)
)

% Xác su?t tích l?y
% Gi? s? parent_number = 10
% Numerator parent_number: -1: 1 ðý?c s? d?ng ð? t?o m?t chu?i s?
% Denominator sum (parent_number: -1: 1) là m?t k?t qu? t?ng (m?t s?)
%
% Phân t? 10 9 8 7 6 5 4 3 2 1
% M?u s? 55
% Chia cho 0,1818 0,1636 0,1455 0,1273 0,1091 0,0909 0,0727 0,0545 0,0364 0,0182
% Tích l?y 0,1818 0,3455 0,4909 0,6182 0,7273 0,8182 0,8909 0,9455 0,9818 1,0000
%
% K?t qu? ho?t ð?ng có th? ðý?c nh?n th?y
% Hàm xác su?t tích l?y là m?t hàm phát tri?n ch?m t? 0 ð?n 1
% V? xác su?t thêm vào sau ngày càng nh? (d?y s? ðý?c s?p x?p theo th? t? ?o gi?m d?n)
cumulative_probabilities = cumsum((parent_number:-1:1) / sum(parent_number:-1:1)); % 1 d?y s? có ð? dài là parent_number

% Th? l?c t?t nh?t
% Th? l?c t?t nh?t c?a m?i th? h? l?n ð?u tiên ðý?c kh?i t?o thành 1
best_fitness = ones(maximal_generation, 1);

% Ýu tú
% Các giá tr? tham s? c?a gi?i ýu tú c?a m?i th? h? l?n ð?u tiên ðý?c kh?i t?o thành 0
elite = zeros(maximal_generation, number_of_variables);

% S? lý?ng con
% Quy mô dân s? - s? lý?ng b? m? (b? m? là nh?ng cá th? không thay ð?i trong m?i th? h?)
child_number = population_size - parent_number; % s? con trong m?i th? h?

% Dân s? ban ð?u
% population_size týõng ?ng v?i các hàng c?a ma tr?n, m?i hàng ð?i di?n cho 1 cá th?, s? hàng = s? lý?ng cá th? (s? qu?n th?)
% number_of_variables  týõng ?ng v?i các c?t c?a ma tr?n, s? c?t = s? lý?ng tham s? (các ð?c ði?m riêng l? ðý?c bi?u th? b?ng các tham s? này)
population = rand(population_size, number_of_variables);

last_generation = 0; % ghi l?i th? h? khi ra kh?i v?ng l?p

% Ph?n ti?p theo là m?t v?ng l?p for
for generation = 1 : maximal_generation 
    
    % feval ðýa d? li?u vào m?t hàm x? l? ð? xác ð?nh ð? tính toán
    % Ðýa ma tr?n population vào hàm fitness_function
    cost = feval(fitness_function, population); % Tính toán th? l?c cho t?t c? các cá th??population_size *1?

    % index ghi l?i s? hàng ban ð?u cho m?i giá tr? sau khi s?p x?p
    [cost, index] = sort(cost); % S?p x?p các giá tr? c?a hàm th? d?c t? nh? ð?n l?n

    % index(1:parent_number) 
    % S? hàng c?a population c?a các cá th? parent_number ð?u tiên v?i cost th?p hõn
    % Ch?n ph?n (parent_number) nhý cha m?, parent_number týõng ?ng v?i các xác su?t chéo
    population = population(index(1:parent_number), :); % Gi? m?t vài cá th? vý?t tr?i hõn
    % Có th? th?y ma trân population liên t?c thay ð?i

    % cost sau l?n s?p x?p sort trý?c, ma tr?n ð? ðý?c thay ð?i thành th? t? tãng d?n
    % cost(1) là th? l?c t?t nh?t cho th? h? này
    best_fitness(generation) = cost(1); % Ghi l?i th? l?c t?t nh?t c?a th? h? này

    % D?ng ð?u tiên c?a ma tr?n population là nh?ng cá th? ýu tú c?a th? h? này
    elite(generation, :) = population(1, :); % Ghi l?i gi?i pháp t?i ýu c?a th? h? này (ýu tú)

    % N?u gi?i pháp t?i ýu c?a th? h? này ð? t?t, d?ng s? phát tri?n
    if best_fitness(generation) < minimal_cost 
        last_generation = generation;
        break; 
    end
    
    % Ð?t bi?n chéo t?o ra m?t qu?n th? m?i

    % B?t ð?u qua l?i nhi?m s?c th?
    for child = 1:2:child_number % Kích thý?c bý?c là 2 v? m?i l?n tái t? h?p s? t?o ra 2 con
        
        % ð? dài c?a cumulative_probabilities là parent_number
        % Ch?n ng?u nhiên 2 cha m? t? nó  (child+parent_number)%parent_number
        mother = find(cumulative_probabilities > rand, 1); % Ch?n m? t?t hõn
        father = find(cumulative_probabilities > rand, 1); % Ch?n cha t?t hõn
        
        % ceil?giá tr? tr?n?làm tr?n
        % rand kh?i t?o m?t s? ng?u nhiên
        % Ch?n ng?u nhiên m?t c?t, giá tr? c?t này b? thay ð?i
        crossover_point = ceil(rand*number_of_variables); % xác ð?nh ng?u nhiên s? trao ð?i c?a nhi?m s?c th?
        
        % N?u crossover_point = 3, number_of_variables = 5
        % mask1 = 1     1     1     0     0
        % mask2 = 0     0     0     1     1
        mask1 = [ones(1, crossover_point), zeros(1, number_of_variables - crossover_point)];
        mask2 = not(mask1);
        
        % Nh?n 4 nhi?m s?c th? riêng bi?t
        % Chú ? là. *
        mother_1 = mask1 .* population(mother, :); % Ph?n trý?c c?a nhi?m s?c th? m?
        mother_2 = mask2 .* population(mother, :); % Ph?n sau c?a nhi?m s?c th? m?
        
        father_1 = mask1 .* population(father, :); % Ph?n trý?c c?a nhi?m s?c th? cha
        father_2 = mask2 .* population(father, :); % Ph?n sau c?a nhi?m s?c th? cha
        
        % Nh?n th? h? ti?p theo
        population(parent_number + child, :) = mother_1 + father_2; % m?t cá th? con
        population(parent_number+child+1, :) = mother_2 + father_1; % m?t cá th? con khác
        
    end % K?t thúc c?a trao ð?i nhi?m s?n th?
    
    
    % Bi?n th? nhi?m s?c th? b?t ð?u
    
    % Dân s? bi?n th?
    mutation_population = population(2:population_size, :); % Các cá th? ýu tú không tham gia vào ð?t bi?n, v? v?y b?t ð?u t? 2
    
    number_of_elements = (population_size - 1) * number_of_variables; % s? lý?ng t?t c? các gen
    number_of_mutations = ceil(number_of_elements * mutation_rate); % S? lý?ng ð?t bi?n (t?ng s? gen * t? l? ð?t bi?n)
    
    % rand(1, number_of_mutations) T?o ma tr?n g?m các s? ng?u nhiên number_of_mutations(ph?m vi 0-1)(1*number_of_mutations)
    % Sau khi nhân, m?i ph?n t? c?a ma tr?n ð?i di?n cho v? trí c?a gen thay ð?i (t?a ð? m?t chi?u c?a ph?n t? trong ma tr?n)

    mutation_points = ceil(number_of_elements * rand(1, number_of_mutations)); % xác ð?nh gen b? ð?t bi?n
    
    % Các gen ð? ch?n ðý?c thay th? b?ng m?t s? ng?u nhiên ð? hoàn thành ð?t bi?n
    mutation_population(mutation_points) = rand(1, number_of_mutations); % Th?c hi?n các thao tác gây ð?t bi?n trên các gen ð? ch?n
    
    population(2:population_size, :) = mutation_population; % Dân s? sau khi ð?t bi?n
    
    % K?t thúc c?a s? bi?n ð?i nhi?m s?c th?
   
end % K?t thúc chu k? ti?n hoá
