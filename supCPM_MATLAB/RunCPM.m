path = '.../supCPM-main/supCPM_MATLAB/results/';  % manually set the path of output file 
addpath(".../supCPM-main/supCPM_MATLAB/supPCA");  % add the path of supPCA
addpath("...supCPM-main/supCPM_MATLAB/drtoolbox"); % add the path of drtoolbox
addpath(".../supCPM-main/supCPM_MATLAB/drtoolbox/techniques");
addpath(".../supCPM-main/supCPM_MATLAB/umap"); % add the path of umap
addpath(".../supCPM-main/supCPM_MATLAB/supCPM"); % add the path of supCPM
% need to run RunSeurat.R first to get the output of tSNE and UMAP
rnamix_pca = readmatrix([path,'RNAmix_pca.csv'],'Range',[2 2]);
rnamix_scale = readmatrix([path,'RNAmix_scale.csv'],'Range',[2 2]);
rnamix_scale = rnamix_scale';
rnamix_tsne = readmatrix([path,'RNAmix_tsne.csv'],'Range',[2 2]);
rnamix_umap = readmatrix([path,'RNAmix_umap.csv'],'Range',[2 2]);
rnamix_label = readmatrix([path,'RNAmix_label.csv'],'Range',[2 2]);

pbmc_pca = readmatrix([path,'pbmc3k_pca.csv'],'Range',[2 2]);
pbmc_scale = readmatrix([path,'pbmc3k_scale.csv'],'Range',[2 2]);
pbmc_scale = pbmc_scale';
pbmc_tsne = readmatrix([path,'pbmc3k_tsne.csv'],'Range',[2 2]);
pbmc_umap = readmatrix([path,'pbmc3k_umap.csv'],'Range',[2 2]);
pbmc_label = readmatrix([path,'pbmc3k_label.csv'],'Range',[2 3]);

synthetic_pca = readmatrix([path,'synthetic_pca.csv'],'Range',[2 2]);
synthetic_tsne = readmatrix([path,'synthetic_tsne.csv'],'Range',[2 2]);
synthetic_umap = readmatrix([path,'synthetic_umap.csv'],'Range',[2 2]);
synthetic_label = readmatrix([path,'synthetic_label.csv'],'Range',[2 2]);
synthetic = readmatrix([path,'synthetic.csv'],'Range',[2 2]);

cancer_pca = readmatrix([path,'cancer_pca.csv'],'Range',[2 2]);
cancer_scale = readmatrix([path,'cancer_scale.csv'],'Range',[2 2]);
cancer_scale = cancer_scale';
cancer_tsne = readmatrix([path,'cancer_tsne.csv'],'Range',[2 2]);
cancer_umap = readmatrix([path,'cancer_umap.csv'],'Range',[2 2]);
cancer_label = readmatrix([path,'cancer_label.csv'],'Range',[2 3]);

covid_pca = readmatrix([path,'COVID_pca.csv'],'Range',[2 2]);
covid_label = readmatrix([path,'COVID_label.csv'],'Range',[2 3]);
covid_scale = readmatrix([path,'COVID_scale.csv'],'Range',[2 2]);
covid_scale = covid_scale';

eb_pca = readmatrix([path,'EB_pca.csv'],'Range',[2 2]);
eb_label = readmatrix([path,'EB_label.csv'],'Range',[2 2]);
eb_scale = readmatrix([path,'EB_scale.csv'],'Range',[2 2]);
eb_scale = eb_scale';

nkt_pca = readmatrix([path,'CovidT_pca.csv'],'Range',[2 2]);
nkt_label = readmatrix([path,'CovidT_label.csv'],'Range',[2 2]);
nkt_scale = readmatrix([path,'CovidT_scale.csv'],'Range',[2 2]);
nkt_scale = nkt_scale';
%% EB
% run SupUMAP
eb_supUMAP = run_umap([eb_pca(:,1:20),eb_label],...,
                             'label_column','end','metric','cosine');
% run SupPCA
param.ktype_y = 'delta_cls';
param.kparam_y = 1;
eb_supPCA = SPCA(eb_scale',eb_label',2,param);
eb_supPCA = eb_supPCA';
% MDS
X = eb_pca(:,1:20);
label = eb_label;
covar = zeros(1,length(unique(label)));
k = 1;
for i = unique(label)'
    cl = find(label==i);
    covar(k) = trace(cov(X(cl,:)));
    k = k+1;
end
[eb_MDS,knc_mds,cpd_mds] = mds_quality(X,label,3);
eb_MDS = [eb_MDS,covar'];
writematrix(eb_supUMAP,[path,'EB_supUMAP.csv']);
writematrix(eb_supPCA,[path,'EB_supPCA.csv']);
writematrix(eb_MDS,[path,'EB_MDS.csv']);
%% NKT
% run SupUMAP
nkt_supUMAP = run_umap([nkt_pca(:,1:30),nkt_label],...,
                             'label_column','end','metric','cosine');
% run SupPCA
param.ktype_y = 'delta_cls';
param.kparam_y = 1;
nkt_supPCA = SPCA(nkt_scale',nkt_label',2,param);
nkt_supPCA = nkt_supPCA';
% MDS
X = nkt_pca(:,1:30);
label = nkt_label;
covar = zeros(1,length(unique(label)));
k = 1;
for i = unique(label)'
    cl = find(label==i);
    covar(k) = trace(cov(X(cl,:)));
    k = k+1;
end
[nkt_MDS,knc_mds,cpd_mds] = mds_quality(X,label,3);
nkt_MDS = [nkt_MDS,covar'];
writematrix(nkt_supUMAP,[path,'NKT_supUMAP.csv']);
writematrix(nkt_supPCA,[path,'NKT_supPCA.csv']);
writematrix(nkt_MDS,[path,'NKT_MDS.csv']);
%% COVID
% run SupUMAP
covid_supUMAP = run_umap([covid_pca(:,1:40),covid_label],...,
                             'label_column','end','metric','cosine');
% run SupPCA
param.ktype_y = 'delta_cls';
param.kparam_y = 1;
covid_supPCA = SPCA(covid_scale',covid_label',2,param);
covid_supPCA = covid_supPCA';
% MDS
X = covid_pca(:,1:40);
label = covid_label;
covar = zeros(1,length(unique(label)));
k = 1;
for i = unique(label)'
    cl = find(label==i);
    covar(k) = trace(cov(X(cl,:)));
    k = k+1;
end
[covid_MDS,knc_mds,cpd_mds] = mds_quality(X,label,3);
covid_MDS = [covid_MDS,covar'];
writematrix(covid_supUMAP,[path,'COVID_supUMAP.csv']);
writematrix(covid_supPCA,[path,'COVID_supPCA.csv']);
writematrix(covid_MDS,[path,'COVID_MDS.csv']);

%% Synthetic
%params: data,label,no_dims,compel_force,geodist,degree,ratio,k,change,niter,seed,factor
synthetic_cpm = supCPM(synthetic_pca(:,1:20),synthetic_label,2,0,1,1,0,7,600,500,123,1);
synthetic_supCPM_eu = supCPM(synthetic_pca(:,1:20),synthetic_label,2,1,0,1,0.5,7,500,2000,123,1.2);
synthetic_supCPM_geo = supCPM(synthetic_pca(:,1:20),synthetic_label,2,1,1,1,0.5,7,500,2000,123,1.2);
% run SupUMAP
synthetic_supUMAP = run_umap([synthetic_pca(:,1:20),synthetic_label],...,
                             'label_column','end','metric','cosine');
% run SupPCA
param.ktype_y = 'delta_cls';
param.kparam_y = 1;
synthetic_supPCA = SPCA(synthetic',synthetic_label',2,param);
synthetic_supPCA = synthetic_supPCA';
% MDS
X = synthetic_pca(:,1:20);
label = synthetic_label;
covar = zeros(1,length(unique(label)));
k = 1;
for i = unique(label)'
    cl = find(label==i);
    covar(k) = trace(cov(X(cl,:)));
    k = k+1;
end
[synthetic_MDS,knc_mds,cpd_mds] = mds_quality(X,label,3);
synthetic_MDS = [synthetic_MDS,covar'];

[cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo]     = embedding_quality(synthetic_supCPM_geo,synthetic_pca,synthetic_label,2,5,3600);
[cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu]        = embedding_quality(synthetic_supCPM_eu,synthetic_pca,synthetic_label,2,5,3600);
[cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm]        = embedding_quality(synthetic_cpm,synthetic_pca,synthetic_label,2,5,3600);
[cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne]     = embedding_quality(synthetic_tsne,synthetic_pca,synthetic_label,2,5,3600);
[cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP]  = embedding_quality(synthetic_supUMAP,synthetic_pca,synthetic_label,2,5,3600);
[cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca]        = embedding_quality(synthetic_pca(:,1:2),synthetic_pca,synthetic_label,2,5,3600);
[cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca]        = embedding_quality(synthetic_supPCA,synthetic_pca,synthetic_label,2,5,3600);
[cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]     = embedding_quality(synthetic_umap,synthetic_pca,synthetic_label,2,5,3600);

metric_synthetic = [cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo; cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu;  
                    cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm;  cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne;
                    cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP; cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca;
                    cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca;  cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]';
%% RNAmix
% run CPM & supCPM
%data,label,no_dims,compel_force,geodist,degree,ratio,k,change,niter,seed,factor
rnamix_cpm = supCPM(rnamix_pca(:,1:10),rnamix_label,2,1,0,1,0,8,1040,900,123,1);
rnamix_supCPM_eu = supCPM(rnamix_pca(:,1:10),rnamix_label,2,1,0,2,0.7,7,500,2000,123,1.3);
rnamix_supCPM_geo = supCPM(rnamix_pca(:,1:10),rnamix_label,2,1,1,1,0.7,7,400,2000,123,1.3);
% run SupUMAP
rnamix_supUMAP = run_umap([rnamix_pca(:,1:10),rnamix_label],'label_column','end',...
        'metric','cosine');
 
% run SupPCA
param.ktype_y = 'delta_cls';
param.kparam_y = 1;         
rnamix_supPCA = SPCA(rnamix_scale',(rnamix_label+1)',2,param);
rnamix_supPCA = rnamix_supPCA';
% MDS
X = rnamix_pca(:,1:10);
label = rnamix_label;
covar = zeros(1,length(unique(label)));
k = 1;
for i = unique(label)'
    cl = find(label==i);
    covar(k) = trace(cov(X(cl,:)));
    k = k+1;
end
[rnamix_MDS,knc_mds,cpd_mds,D] = mds_quality(X,label,3);
rnamix_MDS = [rnamix_MDS,covar'];

% Metric
[cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo]     = embedding_quality(rnamix_supCPM_geo,rnamix_pca(:,1:10),rnamix_label,3,5,340);
[cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu]        = embedding_quality(rnamix_supCPM_eu,rnamix_pca(:,1:10),rnamix_label,3,5,340);
[cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm]        = embedding_quality(rnamix_cpm,rnamix_pca(:,1:10),rnamix_label,3,5,340);
[cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne]     = embedding_quality(rnamix_tsne,rnamix_pca(:,1:10),rnamix_label,3,5,340);
[cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP]  = embedding_quality(rnamix_supUMAP,rnamix_pca(:,1:10),rnamix_label,3,5,340);
[cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca]        = embedding_quality(rnamix_pca(:,1:2),rnamix_pca(:,1:10),rnamix_label,3,5,340);
[cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca]        = embedding_quality(rnamix_supPCA,rnamix_pca(:,1:10),rnamix_label,3,5,340);
[cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]     = embedding_quality(rnamix_umap,rnamix_pca(:,1:10),rnamix_label,3,5,340);

metric_rnamix = [cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo;  cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu;  
                 cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm;  cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne;
                 cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP; cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca;
                 cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca;  cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]';

%% PBMC3k
%data,label,no_dims,compel_force,geodist,degree,ratio,k,change,niter,seed,factor
pbmc_cpm = supCPM(pbmc_pca(:,1:30),pbmc_label,2,0,1,1,0,7,500,400,123,1);
pbmc_supCPM_eu = supCPM(pbmc_pca(:,1:30),pbmc_label,2,1,0,2,0.8,7,500,3000,123,1.3);
pbmc_supCPM_geo= supCPM(pbmc_pca(:,1:30),pbmc_label,2,1,1,1,0.6,7,500,3000,123,1.3);

% run SupUMAP
pbmc_supUMAP = run_umap([pbmc_pca(:,1:30),pbmc_label],'label_column','end',...
                        'metric','cosine');
% run SupPCA
param.ktype_y = 'delta_cls';
param.kparam_y = 1;
pbmc_supPCA = SPCA(pbmc_scale',pbmc_label',2,param);
pbmc_supPCA = pbmc_supPCA';
% MDS
X = pbmc_pca(:,1:30);
label = pbmc_label;
covar = zeros(1,length(unique(label)));
k = 1;
for i = unique(label)'
    cl = find(label==i);
    covar(k) = trace(cov(X(cl,:)));
    k = k+1;
end
[pbmc_MDS,knc_mds,cpd_mds,D] = mds_quality(X,label,3);
pbmc_MDS = [pbmc_MDS,covar'];

% Metrics
[cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm]     = embedding_quality(pbmc_cpm,pbmc_pca(:,1:30),pbmc_label,3,5,2700);
[cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo]     = embedding_quality(pbmc_supCPM_geo,pbmc_pca(:,1:30),pbmc_label,3,5,2700);
[cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu]        = embedding_quality(pbmc_supCPM_eu,pbmc_pca(:,1:30),pbmc_label,3,5,2700);
[cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne]     = embedding_quality(pbmc_tsne,pbmc_pca(:,1:30),pbmc_label,3,5,2700);
[cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP]  = embedding_quality(pbmc_supUMAP,pbmc_pca(:,1:30),pbmc_label,3,5,2700);
[cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca]  = embedding_quality(pbmc_supPCA,pbmc_pca(:,1:30),pbmc_label,3,5,2700);
[cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca]        = embedding_quality(pbmc_pca(:,1:2),pbmc_pca(:,1:30),pbmc_label,3,5,2700);
[cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]     = embedding_quality(pbmc_umap,pbmc_pca(:,1:30),pbmc_label,3,5,2700);

metric_pbmc = [cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo;  cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu;  
               cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm;  cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne;
               cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP;  cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca;
               cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca;  cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]';

%% Cancer
%data,label,no_dims,compel_force,geodist,degree,ratio,k,change,niter,seed,factor
cancer_cpm = supCPM(cancer_pca(:,1:20),cancer_label,2,0,1,1,0,30,510,500,123,1);
cancer_supCPM_eu =  supCPM(cancer_pca(:,1:20),cancer_label,2,1,0,2,0.6,7,500,3000,123,1.3);
cancer_supCPM_geo =  supCPM(cancer_pca(:,1:20),cancer_label,2,0,1,1,0.6,30,1000,3000,123,1.3);
% run SupUMAP
cancer_supUMAP = run_umap([cancer_pca(:,1:20),cancer_label],'label_column','end','metric','cosine');
% run SupPCA
param.ktype_y = 'delta_cls';
param.kparam_y = 1;
cancer_supPCA = SPCA(cancer_scale',cancer_label',2,param);
cancer_supPCA = cancer_supPCA';
% MDS
X = cancer_pca(:,1:20);
label = cancer_label;
covar = zeros(1,length(unique(label)));
k = 1;
for i = unique(label)'
    cl = find(label==i);
    covar(k) = trace(cov(X(cl,:)));
    k = k+1;
end
[cancer_MDS,knc_mds,cpd_mds,D] = mds_quality(X,label,3);
cancer_MDS = [cancer_MDS,covar'];

% Metrics
[cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo]     = embedding_quality(cancer_supCPM_geo,cancer_pca(:,1:30),cancer_label,3,5,1213);
[cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu]        = embedding_quality(cancer_supCPM_eu,cancer_pca(:,1:30),cancer_label,3,5,1213);
[cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm]     = embedding_quality(cancer_cpm,cancer_pca(:,1:30),cancer_label,3,5,1213);
[cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne]     = embedding_quality(cancer_tsne,cancer_pca(:,1:30),cancer_label,3,5,1213);
[cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]     = embedding_quality(cancer_umap,cancer_pca(:,1:30),cancer_label,3,5,1213);
[cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca]        = embedding_quality(cancer_pca(:,1:2),cancer_pca(:,1:30),cancer_label,3,5,1213);
[cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca]        = embedding_quality(cancer_supPCA,cancer_pca(:,1:30),cancer_label,3,5,1213);
[cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP]  = embedding_quality(cancer_supUMAP,cancer_pca(:,1:30),cancer_label,3,5,1213);

metric_cancer = [cv_geo,knc_geo,cpd_geo,fisher_geo,knn_geo;  cv_eu,knc_eu,cpd_eu,fisher_eu,knn_eu;  
               cv_cpm,knc_cpm,cpd_cpm,fisher_cpm,knn_cpm;  cv_tsne,knc_tsne,cpd_tsne,fisher_tsne,knn_tsne;
               cv_supUMAP,knc_supUMAP,cpd_supUMAP,fisher_supUMAP,knn_supUMAP; cv_pca,knc_pca,cpd_pca,fisher_pca,knn_pca;
               cv_spca,knc_spca,cpd_spca,fisher_spca,knn_spca;  cv_umap,knc_umap,cpd_umap,fisher_umap,knn_umap]';

%%
writematrix(rnamix_cpm,[path,'RNAmix_CPM.csv']);
writematrix(rnamix_supCPM_geo,[path,'RNAmix_Geo.csv']);
writematrix(rnamix_supCPM_eu,[path,'RNAmix_Eucli.csv']);
writematrix(rnamix_supUMAP,[path,'RNAmix_supUMAP.csv']);
writematrix(rnamix_supPCA,[path,'RNAmix_supPCA.csv']);
writematrix(rnamix_MDS,[path,'RNAmix_MDS.csv']);
writematrix(metric_rnamix,[path,'RNAmix_metric.csv']);

writematrix(pbmc_cpm,[path,'pbmc3k_CPM.csv']);
writematrix(pbmc_supCPM_geo,[path,'pbmc3k_Geo.csv']);
writematrix(pbmc_supCPM_eu,[path,'pbmc3k_Eucli.csv']);
writematrix(pbmc_supUMAP,[path,'pbmc3k_supUMAP.csv']);
writematrix(pbmc_supPCA,[path,'pbmc3k_supPCA.csv']);
writematrix(pbmc_MDS,[path,'pbmc3k_MDS.csv']);
writematrix(metric_pbmc,[path,'pbmc3k_metric.csv']);

writematrix(cancer_cpm,[path,'cancer_CPM.csv']);
writematrix(cancer_supCPM_geo,[path,'cancer_Geo.csv']);
writematrix(cancer_supCPM_eu,[path,'cancer_Eucli.csv']);
writematrix(cancer_supUMAP,[path,'cancer_supUMAP.csv']);
writematrix(cancer_supPCA,[path,'cancer_supPCA.csv']);
writematrix(cancer_MDS,[path,'cancer_MDS.csv']);
writematrix(metric_cancer,[path,'cancer_metric.csv']);

writematrix(synthetic_cpm,[path,'synthetic_CPM.csv']);
writematrix(synthetic_supCPM_geo,[path,'synthetic_Geo.csv']);
writematrix(synthetic_supCPM_eu,[path,'synthetic_Eucli.csv']);
writematrix(synthetic_supUMAP,[path,'synthetic_supUMAP.csv']);
writematrix(synthetic_supPCA,[path,'synthetic_supPCA.csv']);
writematrix(synthetic_MDS,[path,'synthetic_MDS.csv']);
writematrix(metric_synthetic,[path,'synthetic_metric.csv']);