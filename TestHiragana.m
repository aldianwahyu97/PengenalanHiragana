clc;clear;close all;
 
image_folder = 'D:\Aldian\Irwandani\data test 1\';
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
    target = zeros(1,6);
    target(:,1:2) = 1; %kelas A
    target(:,3:4) = 2; %kelas I
    target(:,5:6) = 3; %Kelas U
end


load 'D:\Aldian\Irwandani\net.mat'
output = round(sim(net,input))

[m,n] = find(output==target);
akurasi = sum(m)/total_images*100