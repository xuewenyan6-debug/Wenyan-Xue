%% 分布式PMP与集中式PMP计算时间比较分析（紧凑分组无间距版）
clear; clc; close all;

% 数据定义 - 假设值（基于典型计算复杂度分析）
% 场景1: 3架无人机巡检28架风机
uav3_labels = {'UAV1', 'UAV2', 'UAV3'};

% 分布式PMP计算时间（每架无人机独立计算）
dist_pmp_3 = [0.12, 0.15, 0.13];  % 单位：秒

% 集中式PMP计算时间（整个系统一起计算）
central_pmp_3 = [0.85, 0.85, 0.85];  % 所有无人机使用相同的总计算时间

% 场景2: 6架无人机巡检40架风机
uav6_labels = {'UAV1', 'UAV2', 'UAV3', 'UAV4', 'UAV5', 'UAV6'};

% 分布式PMP计算时间（每架无人机独立计算）
dist_pmp_6 = [0.16, 0.165, 0.155, 0.17, 0.162, 0.18];  % 单位：秒

% 集中式PMP计算时间（整个系统一起计算）
central_pmp_6 = [2.8, 2.8, 2.8, 2.8, 2.8, 2.8];  % 所有无人机使用相同的总计算时间

% 颜色定义
color_dist = [0.3, 0.5, 0.5];  % 蓝色 - 分布式方法
color_cent = [0.6, 0.4, 0.3];  % 红色 - 集中式方法
color_threshold = [0.9, 0.6, 0.1];  % 橙色 - 阈值线

% 创建图形窗口
figure('Position', [100, 100, 1400, 600]);

% ===================== 子图1: 3架无人机场景 =====================
subplot(1, 2, 1);
hold on;

% 设置分组参数
n_groups_3 = length(uav3_labels);  % UAV数量
group_width = 0.6;  % 每组（UAV）的总宽度
bar_width = group_width;  % 现在每组内两个柱子合并为一个宽柱子
group_spacing = 0.4;  % 组与组之间的间距

% 计算每个柱子的位置（现在每组只有一个柱子位置）
group_centers_3 = zeros(1, n_groups_3);  % 存储每组（UAV）的中心位置

% 准备数据矩阵 - 每行是一个UAV的[分布式, 集中式]数据
data_matrix_3 = [dist_pmp_3', central_pmp_3'];

% 计算每组的位置
for i = 1:n_groups_3
    % 计算该组的中心位置
    group_center = (i-1) * (group_width + group_spacing) + group_width/2 + 0.5;
    group_centers_3(i) = group_center;
end

% 使用堆叠柱状图，但设置宽度为1使柱子紧贴
bars1 = bar(group_centers_3, data_matrix_3, bar_width, 'stacked');

% 设置柱状图颜色
bars1(1).FaceColor = color_dist;
bars1(1).EdgeColor = 'k';  % 黑色边框
bars1(2).FaceColor = color_cent;
bars1(2).EdgeColor = 'k';  % 黑色边框

% 移除堆叠效果：将分布式部分放在底部，集中式部分堆叠在上方
% 但我们需要计算每个部分的中心位置进行标注

% 标注分布式部分数值（在柱子底部）
for i = 1:n_groups_3
    % 分布式部分位于柱子底部
    dist_height = data_matrix_3(i, 1);
    dist_center = group_centers_3(i);
    text(dist_center, dist_height/2, sprintf('%.2f', dist_height), ...
        'HorizontalAlignment', 'center', 'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', 'w');  % 白色文字，增加对比度
end

% 标注集中式部分数值（在柱子顶部）
for i = 1:n_groups_3
    % 集中式部分位于柱子顶部
    cent_height = data_matrix_3(i, 2);
    total_height = sum(data_matrix_3(i, :), 2);
    cent_center = group_centers_3(i);
    text(cent_center, total_height - cent_height/2, sprintf('%.2f', cent_height), ...
        'HorizontalAlignment', 'center', 'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', 'w');  % 白色文字，增加对比度
end

% 设置x轴标签（在每个组的中心位置）
set(gca, 'XTick', group_centers_3, 'XTickLabel', uav3_labels);

% 添加图例
legend({'The proposed DDG', ' The centralized DG'}, 'Location', 'northwest', 'FontSize', 10);

% 添加标题和标签
title('(a) 3 UAVs Inspecting 28 Wind Turbines', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('UAV ID', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Computation time for 3 UAVs inspecting 28 wind turbines(s)', 'FontSize', 11, 'FontWeight', 'bold');

% 添加实时性阈值线 (1 Hz = 1秒)
threshold = 1.0;
x_limits = xlim;
plot(x_limits, [threshold, threshold], '--', 'Color', color_threshold, ...
    'LineWidth', 1.5, 'DisplayName', sprintf('Real-Time Threshold (%.1f s)', threshold));

% 计算加速比（分布式相对于集中式）
acceleration_ratio_3 = mean(central_pmp_3) / mean(dist_pmp_3);

% 在图上添加加速比信息
text(mean(group_centers_3), max(sum(data_matrix_3, 2))*0.9, ...
    sprintf('Average Acceleration Ratio: %.1f×', acceleration_ratio_3), ...
    'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold', ...
    'BackgroundColor', [1, 1, 0.9], 'EdgeColor', 'black');

% 图形美化
%grid on;
%grid minor;
ylim([0, max(sum(data_matrix_3, 2))*1.15]);  % 设置y轴范围
xlim([min(group_centers_3) - bar_width, max(group_centers_3) + bar_width]);  % 设置x轴范围
hold off;

% ===================== 子图2: 6架无人机场景 =====================
subplot(1, 2, 2);
hold on;

% 设置分组参数
n_groups_6 = length(uav6_labels);  % UAV数量
group_width = 0.6;  % 每组（UAV）的总宽度
bar_width = group_width;  % 现在每组内两个柱子合并为一个宽柱子
group_spacing = 0.4;  % 组与组之间的间距

% 计算每组的位置
group_centers_6 = zeros(1, n_groups_6);  % 存储每组（UAV）的中心位置

% 准备数据矩阵 - 每行是一个UAV的[分布式, 集中式]数据
data_matrix_6 = [dist_pmp_6', central_pmp_6'];

% 计算每组的位置
for i = 1:n_groups_6
    % 计算该组的中心位置
    group_center = (i-1) * (group_width + group_spacing) + group_width/2 + 0.5;
    group_centers_6(i) = group_center;
end

% 使用堆叠柱状图，但设置宽度为1使柱子紧贴
bars2 = bar(group_centers_6, data_matrix_6, bar_width, 'stacked');

% 设置柱状图颜色
bars2(1).FaceColor = color_dist;
bars2(1).EdgeColor = 'k';  % 黑色边框
bars2(2).FaceColor = color_cent;
bars2(2).EdgeColor = 'k';  % 黑色边框

% 标注分布式部分数值（在柱子底部）
for i = 1:n_groups_6
    % 分布式部分位于柱子底部
    dist_height = data_matrix_6(i, 1);
    dist_center = group_centers_6(i);
    text(dist_center, dist_height/2, sprintf('%.2f', dist_height), ...
        'HorizontalAlignment', 'center', 'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', 'w');  % 白色文字，增加对比度
end

% 标注集中式部分数值（在柱子顶部）
for i = 1:n_groups_6
    % 集中式部分位于柱子顶部
    cent_height = data_matrix_6(i, 2);
    total_height = sum(data_matrix_6(i, :), 2);
    cent_center = group_centers_6(i);
    text(cent_center, total_height - cent_height/2, sprintf('%.2f', cent_height), ...
        'HorizontalAlignment', 'center', 'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', 'w');  % 白色文字，增加对比度
end

% 设置x轴标签（在每个组的中心位置）
set(gca, 'XTick', group_centers_6, 'XTickLabel', uav6_labels);

% 添加图例
legend({'The proposed DDG', ' The centralized DG'}, 'Location', 'northwest', 'FontSize', 10);

% 添加标题和标签
%title('(b) 6 UAVs inspecting 40 wind turbines', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('UAV ID', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Computation time for 6 UAVs inspecting 40 wind turbines (s)', 'FontSize', 11, 'FontWeight', 'bold');

% 添加实时性阈值线 (1 Hz = 1秒)
x_limits = xlim;
plot(x_limits, [threshold, threshold], '--', 'Color', color_threshold, ...
    'LineWidth', 1.5, 'DisplayName', sprintf('Real-Time Threshold (%.1f s)', threshold));

% 计算加速比（分布式相对于集中式）
acceleration_ratio_6 = mean(central_pmp_6) / mean(dist_pmp_6);

% 在图上添加加速比信息
text(mean(group_centers_6), max(sum(data_matrix_6, 2))*0.9, ...
    sprintf('Average Acceleration Ratio: %.1f×', acceleration_ratio_6), ...
    'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold', ...
    'BackgroundColor', [1, 1, 0.9], 'EdgeColor', 'black');

% 图形美化
%grid on;
%grid minor;
ylim([0, max(sum(data_matrix_6, 2))*1.15]);  % 设置y轴范围
xlim([min(group_centers_6) - bar_width, max(group_centers_6) + bar_width]);  % 设置x轴范围
hold off;

% ===================== 整体图形设置 =====================
% 添加整体标题
sgtitle('Comparison of computation time:The proposed DDG vs The centralized DG', ...
    'FontSize', 14, 'FontWeight', 'bold');

% 调整子图间距
set(gcf, 'Color', 'white');

% 添加整体分析说明
annotation('textbox', [0.15, 0.01, 0.7, 0.04], 'String', ...
    'Note: For each UAV, the Distributed PMP (blue, bottom) and Centralized PMP (red, top) segments are combined into a single bar without gaps.', ...
    'HorizontalAlignment', 'center', 'FontSize', 9, 'EdgeColor', 'none', ...
    'BackgroundColor', [0.95, 0.95, 0.95]);

% 保存图形
saveas(gcf, 'distributed_vs_centralized_computation_time_no_gap.png');
print(gcf, 'distributed_vs_centralized_computation_time_no_gap', '-dpng', '-r300');

fprintf('图形已生成并保存。\n');
fprintf('3 UAV场景：分布式平均 %.3f s，集中式平均 %.3f s，加速比 %.1f×\n', ...
    mean(dist_pmp_3), mean(central_pmp_3), acceleration_ratio_3);
fprintf('6 UAV场景：分布式平均 %.3f s，集中式平均 %.3f s，加速比 %.1f×\n', ...
    mean(dist_pmp_6), mean(central_pmp_6), acceleration_ratio_6);