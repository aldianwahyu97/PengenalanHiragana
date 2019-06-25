clc;clear;close all;
 
image_folder = 'D:\Aldian\Irwandani\data train 1\';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);
x=[];
y=[];

for n = 1:total_images
    full_name= fullfile(image_folder, filenames(n).name);
    
    %%Preprocessing
    our_images = imread(full_name);
    BW=im2bw(our_images); %preprocessing
    
    %%Pengambilan Fitur
    verticalProfile = sum(BW, 2); %fitur 1
    horizontalProfile = sum(BW, 1); %fitur 2
    meanV=mean(mean(verticalProfile)); %fitur 1
    meanH=mean(mean(horizontalProfile)); %fitur 2
    
    x=[x;meanV];
    x2=transpose(x);
    y=[y;meanH];
    y2=transpose(y);
    
    input=[x2;y2]; %input pada jst 
    
    %%Proses Pemberian Label
    target = zeros(1,54);
    target(:,1:18) = 1; %kelas A
    target(:,19:36) = 2; %kelas I
    target(:,37:54) = 3; %Kelas U
    %target(:,55:72) = 4; %Kelas U
    
end

net = newff(input,target,[4 8 8 2],{'logsig','logsig','logsig','logsig'},'trainlm');
net.trainParam.epochs = 100;
net.trainParam.goal = 1e-5;
net = train(net,input,target);
output = round(sim(net,input))
save 'D:\Aldian\Irwandani\net.mat' net

[m,n] = find(output==target);
akurasi = sum(m)/total_images*100