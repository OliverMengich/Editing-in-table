

%%

load('bag.mat')
%%

imds = imageDatastore('test','FileExtensions',{'.jpg','.jfif','.png'},'IncludeSubfolders',true,'LabelSource','foldernames');

augsTest= augmentedImageDatastore([227 227],imds,'ColorPreprocessing','gray2rgb');
%%

[label,scr] = classify(netTransfer,augsTest);

%%
sz = [610 4];
varTypes = {'string','double','double','double'};
varNames = {'ID','leaf_rust','stem_rust','healthy_wheat'};
T = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);
T(:,1) = imds.Files;
%%
for i = 1:numel(imds.Files)
    if label(i) ==("leaf_rust")
        T(i,2:end).leaf_rust=1;
        T(i,2:end).stem_rust=0;
        T(i,2:end).healthy_wheat=0;
    elseif label(i) ==("stem_rust")
        T(i,2:end).leaf_rust=0;
        T(i,2:end).stem_rust=1;
        T(i,2:end).healthy_wheat=0;
    elseif label(i) == ("healthy_wheat")
        T(i,2:end).leaf_rust=0;
        T(i,2:end).stem_rust=0;
        T(i,2:end).healthy_wheat=1;
    end
    
end

%%
tablexy = table(imds.Files);
for j=1:numel(imds.Labels)
    xy = tablexy.Var1(j,:);
    r=xy{:}(:,9:14);
    tablexy.Var1(i,:) = r;
    
end
