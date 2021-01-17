clear; 
close all;

% G?i my_ga �? t�nh to�n
% S? tham s? �? gi?i quy?t v?n �? 10
% T�n ch?c n�ng th? d?c t�y ch?nh my_fitness
% Quy m� d�n s? 100
% Con s? kh�ng thay �?i trong m?i th? h? 50 (t?c l� t? l? ch�o l� 0,5)
% X�c su?t �?t bi?n 0,1 (1/10 s? c� th? s? �?t bi?n)
% �?i s? ti?n h�a t?i �a 10000 10000 th? h?
% Gi� tr? m?c ti�u t?i thi?u 1,0e-6 gi� tr? ch?c n�ng th? d?c c� nh�n <0,000001 k?t th�c
[best_fitness, elite, generation, last_generation] = my_ga(10, 'my_fitness', 100, 50, 0.1, 10000, 1.0e-6);


% �?u ra 10 d?ng cu?i c�ng
% disp(best_fitness(9990:10000,:));
% disp(elite(9990:10000,:))
% �i?u n�y l� kh�ng ph� h?p, v? GA th�?ng nh?y ra kh?i v?ng l?p ? gi?a

% ��y l� �?u ra th�ch h?p
disp(last_generation); 
i_begin = last_generation - 9;
disp(best_fitness(i_begin:last_generation,:));
% Chuy?n �?i gi� tr? elite th�nh ph?m vi v?n �?
my_elite = elite(i_begin:last_generation,:);
my_elite = 2 * (my_elite - 0.5);
disp(my_elite);

% Ti?n h�a c?a th? d?c t?i �u
figure
loglog(1:generation, best_fitness(1:generation), 'linewidth',2)
xlabel('Generation','fontsize',15);
ylabel('Best Fitness','fontsize',15);
set(gca,'fontsize',15,'ticklength',get(gca,'ticklength')*2);

% S? ph�t tri?n c?a gi?i ph�p t?i �u
figure
semilogx(1 : generation, 2 * elite(1 : generation, :) - 1)
xlabel('Generation','fontsize',15);
ylabel('Best Solution','fontsize',15);
set(gca,'fontsize',15,'ticklength',get(gca,'ticklength')*2);