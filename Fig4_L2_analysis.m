load('ELs_Dec16_2021.mat');
temp = ELsDec162021.Properties.VariableNames;
els_names = temp(2:end);
just_adj = table2array(ELsDec162021(2:end,2:end));
N = 26;

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

% similarities
figure('renderer', 'painters', 'position', [0,0,709,636]);
colormap white;
z_control1 = (l2_res-mean(l2_shuff,3))./std(l2_shuff,0,3);
z_control1(z_control1>-1.96) = NaN;
imAlpha=ones(size(z_control1));
imAlpha(~isnan(z_control1))=1;
imAlpha(isnan(z_control1))=0;
imagesc(z_control1,'AlphaData',imAlpha);
set(gca, 'TickLabelInterpreter', 'none', 'LineWidth', 2);
set(gca, 'xtick', 1:26, 'xticklabels',els_names);
xtickangle(90);
set(gca, 'ytick', 1:26, 'yticklabels',els_names);
set(gca, 'FontSize', 12,'TickLength',[0 0]);
set(gca,'color',0*[1 1 1]);

% L-R pairs and following pairs
l_r_inds = [];
for i=1:2:25
    pair = [i,i+1];
    l_r_inds = [l_r_inds; pair];
end
follower_inds = [];
for i=1:1:24
    pair = [i, i+2];
    follower_inds = [follower_inds; pair];
end

z_control1 = (l2_res-mean(l2_shuff,3))./std(l2_shuff,0,3);
l_r_scores = [];
follower_scores = [];
for i=1:size(l_r_inds,1)
    l_r_scores(i) = z_control1(l_r_inds(i,1), l_r_inds(i,2));
end
for i=1:size(follower_inds,1)
    follower_scores(i) = z_control1(follower_inds(i,1), follower_inds(i,2));
end

% differences
% calculate original L2
just_adj(just_adj>1) = 1;
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
z_control1(z_control1<1.96) = NaN;
imAlpha=ones(size(z_control1));
imAlpha(~isnan(z_control1))=1;
imAlpha(isnan(z_control1))=0;
imagesc(z_control1,'AlphaData',imAlpha);
set(gca, 'TickLabelInterpreter', 'none', 'LineWidth', 2);
set(gca, 'xtick', 1:26, 'xticklabels',els_names);
xtickangle(90);
set(gca, 'ytick', 1:26, 'yticklabels',els_names);
set(gca, 'FontSize', 12,'TickLength',[0 0]);
set(gca,'color',0*[1 1 1]);

% sensory and interneurons
load('EL_sens_and_inter.mat');
temp = full_conn.Properties.VariableNames;
el_names = temp(3:end);
just_adj = table2array(full_conn(2:end,3:end));
N = 26;

% get sensory and interneurons
inds_sens = [];
inds_inter = [];
for i=1:1179
    if full_conn{i,2}=='sensory'
        inds_sens = [inds_sens, i-1];
    elseif full_conn{i,2}=='interneuron'
        inds_inter = [inds_inter, i-1];
    end
end

% sensory 
just_sub = just_adj(inds_sens,:);
n_sub = 134;
l2_res = [];
for i=1:N
    for j=1:N
        vec1 = just_sub(:,i);
        vec2 = just_sub(:,j);
        temp = sqrt(sum((vec1-vec2).^2));
        l2_res(i,j) = temp;
    end
end

% control - shuffle the sub matrix 
l2_shuff = [];
for s=1:100
    fly_adj_shuff = just_sub;
    for i=1:N
        fly_adj_shuff(:,i) = fly_adj_shuff(randsample(n_sub,n_sub),i);
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
set(gca, 'xtick', 1:26, 'xticklabels',el_names);
xtickangle(90);
set(gca, 'ytick', 1:26, 'yticklabels',el_names);
set(gca, 'FontSize', 12,'TickLength',[0 0]);
set(gca,'color',0*[1 1 1]);

% interneurons 
just_sub = just_adj(inds_inter,:);
n_sub = 622;
l2_res = [];
for i=1:N
    for j=1:N
        vec1 = just_sub(:,i);
        vec2 = just_sub(:,j);
        temp = sqrt(sum((vec1-vec2).^2));
        l2_res(i,j) = temp;
    end
end

% control - shuffle the sub matrix 
l2_shuff = [];
for s=1:100
    fly_adj_shuff = just_sub;
    for i=1:N
        fly_adj_shuff(:,i) = fly_adj_shuff(randsample(n_sub,n_sub),i);
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
set(gca, 'xtick', 1:26, 'xticklabels',el_names);
xtickangle(90);
set(gca, 'ytick', 1:26, 'yticklabels',el_names);
set(gca, 'FontSize', 12,'TickLength',[0 0]);
set(gca,'color',0*[1 1 1]);