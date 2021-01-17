clear; 
close all;

% G?i my_ga ð? tính toán
% S? tham s? ð? gi?i quy?t v?n ð? 10
% Tên ch?c nãng th? d?c tùy ch?nh my_fitness
% Quy mô dân s? 100
% Con s? không thay ð?i trong m?i th? h? 50 (t?c là t? l? chéo là 0,5)
% Xác su?t ð?t bi?n 0,1 (1/10 s? cá th? s? ð?t bi?n)
% Ð?i s? ti?n hóa t?i ða 10000 10000 th? h?
% Giá tr? m?c tiêu t?i thi?u 1,0e-6 giá tr? ch?c nãng th? d?c cá nhân <0,000001 k?t thúc
[best_fitness, elite, generation, last_generation] = my_ga(10, 'my_fitness', 100, 50, 0.1, 10000, 1.0e-6);


% Ð?u ra 10 d?ng cu?i cùng
% disp(best_fitness(9990:10000,:));
% disp(elite(9990:10000,:))
% Ði?u này là không phù h?p, v? GA thý?ng nh?y ra kh?i v?ng l?p ? gi?a

% Ðây là ð?u ra thích h?p
disp(last_generation); 
i_begin = last_generation - 9;
disp(best_fitness(i_begin:last_generation,:));
% Chuy?n ð?i giá tr? elite thành ph?m vi v?n ð?
my_elite = elite(i_begin:last_generation,:);
my_elite = 2 * (my_elite - 0.5);
disp(my_elite);

% Ti?n hóa c?a th? d?c t?i ýu
figure
loglog(1:generation, best_fitness(1:generation), 'linewidth',2)
xlabel('Generation','fontsize',15);
ylabel('Best Fitness','fontsize',15);
set(gca,'fontsize',15,'ticklength',get(gca,'ticklength')*2);

% S? phát tri?n c?a gi?i pháp t?i ýu
figure
semilogx(1 : generation, 2 * elite(1 : generation, :) - 1)
xlabel('Generation','fontsize',15);
ylabel('Best Solution','fontsize',15);
set(gca,'fontsize',15,'ticklength',get(gca,'ticklength')*2);