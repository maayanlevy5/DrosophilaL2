% figure 7
load('basins_Dec16_2021.mat');
temp = basins_Dec16_2021.Properties.VariableNames;
basins_names = temp(2:end);
just_adj = table2array(basins_Dec16_2021(1:end,2:end));
N = 26;
temp = just_adj(:,7);
temp2 = just_adj(:,8);
just_adj(:,7) = temp2;
just_adj(:,8) = temp;
temp = basins_names(7);
basins_names(7) = basins_names(8);
basins_names(8) = temp;

% calculate original L2
just_a
l2_res = [];
for i=1:N
    for j=1:N
        vec1 = just_adj(:,i);
        vec2 = just_adj(:,j);
        temp = sqrt(sum((vec1-vec2).^2));
        l2_res(i,j) = temp;
    end
end

% control - shuffle the sub matrix 
l2_shuff = [];
for s=1:100
    fly_adj_shuff = just_adj;
    for i=1:N
        fly_adj_shuff(:,i) = fly_adj_shuff(randsample(size(just_adj,1),size(just_adj,1)),i);
    end
    
    % calculate l2
    for i=1:N
        for j=1:N
            vec1 = fly_adj_shuff(:,i);
            vec2 = fly_adj_shuff(:,j);
            temp = sqrt(sum((vec1-vec2).^2));
            l2_shuff(i,j,s) = temp;
        end
    end
end

% left
inds = 1:2:26;
figure('renderer', 'painters', 'position', [0,0,709,636]);
colormap white;
z_control1 = (l2_res-mean(l2_shuff,3))./std(l2_shuff,0,3);
z_control1(z_control1>-1.96) = NaN;
z_control2 = z_control1(inds,inds);
imAlpha=ones(size(z_control2));
imAlpha(~isnan(z_control2))=1;
imAlpha(isnan(z_control2))=0;
imagesc(z_control2,'AlphaData',imAlpha);
set(gca, 'TickLabelInterpreter', 'none', 'LineWidth', 2);
set(gca, 'xtick', 1:13, 'xticklabels',basins_names(inds));
xtickangle(90);
set(gca, 'ytick', 1:13, 'yticklabels',basins_names(inds));
set(gca, 'FontSize', 12,'TickLength',[0 0]);
set(gca,'color',0*[1 1 1]);

% right
inds = 2:2:26;
figure('renderer', 'painters', 'position', [0,0,709,636]);
colormap white;
z_control1 = (l2_res-mean(l2_shuff,3))./std(l2_shuff,0,3);
z_control1(z_control1>-1.96) = NaN;
z_control2 = z_control1(inds,inds);
imAlpha=ones(size(z_control2));
imAlpha(~isnan(z_control2))=1;
imAlpha(isnan(z_control2))=0;
imagesc(z_control2,'AlphaData',imAlpha);
set(gca, 'TickLabelInterpreter', 'none', 'LineWidth', 2);
set(gca, 'xtick', 1:13, 'xticklabels',basins_names(inds));
xtickangle(90);
set(gca, 'ytick', 1:13, 'yticklabels',basins_names(inds));
set(gca, 'FontSize', 12,'TickLength',[0 0]);
set(gca,'color',0*[1 1 1]);

% figure 8
load('ladders_Dec16_2021.mat');
temp = ladders_Dec16_2021.Properties.VariableNames;
ladders_names = temp(2:end);
just_adj = table2array(ladders_Dec16_2021(1:end,2:end));
N = 6;

% calculate original L2
l2_res = [];
for i=1:N
    for j=1:N
        vec1 = just_adj(:,i);
        vec2 = just_adj(:,j);
        temp = sqrt(sum((vec1-vec2).^2));
        l2_res(i,j) = temp;
    end
end

% control - shuffle the sub matrix 
l2_shuff = [];
for s=1:100
    fly_adj_shuff = just_adj;
    for i=1:N
        fly_adj_shuff(:,i) = fly_adj_shuff(randsample(size(just_adj,1),size(just_adj,1)),i);
    end
    
    % calculate l2
    for i=1:N
        for j=1:N
            vec1 = fly_adj_shuff(:,i);
            vec2 = fly_adj_shuff(:,j);
            temp = sqrt(sum((vec1-vec2).^2));
            l2_shuff(i,j,s) = temp;
        end
    end
end

figure('renderer', 'painters', 'position', [0,0,709,636]);
colormap white;
z_control1 = (l2_res-mean(l2_shuff,3))./std(l2_shuff,0,3);
z_control1(z_control1>-1.96) = NaN;
imAlpha=ones(size(z_control1));
imAlpha(~isnan(z_control1))=1;
imAlpha(isnan(z_control1))=0;
imagesc(z_control1,'AlphaData',imAlpha);
set(gca, 'TickLabelInterpreter', 'none', 'LineWidth', 2);
set(gca, 'xtick', 1:6, 'xticklabels',ladders_names);
xtickangle(90);
set(gca, 'ytick', 1:6, 'yticklabels',ladders_names);
set(gca, 'FontSize', 12,'TickLength',[0 0]);
set(gca,'color',0*[1 1 1]);
