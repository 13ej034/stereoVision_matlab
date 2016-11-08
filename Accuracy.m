%% �����p�����[�^�̐��x�]��
%% ������
clear;clc;close all;

%% �����p�����[�^���Ăяo��
% ���O�� Stereo Camera Calibrator �����p�����[�^�𐄒肵�Ă���
load stereoParams.mat

%% �摜��ǂݍ���
image_l = imread('image/left.png');
image_r = imread('image/right.png');

%% �c�݂�␳����
undistort_l = undistortImage(image_l, stereoParams.CameraParameters1);
undistort_r = undistortImage(image_r, stereoParams.CameraParameters2);
[height,width,channel] = size(undistort_l);

%% �O���[�X�P�[���ɕϊ�
gray_l = rgb2gray(undistort_l);
gray_r = rgb2gray(undistort_r);

%% �G�b�W�����o
edge_l = edge(gray_l,'sobel');
edge_r = edge(gray_r,'sobel');

%% �X�e���I�}�b�`���O
disparityRange = [16*5,16*20];
disparityMap = disparity(gray_l,gray_r,'DisparityRange',disparityRange);

%% �����摜��\��
figure
imshow(disparityMap,disparityRange);
title('Disparity Map');
colormap jet
colorbar

%% ���s��Z�̐���
%% �e�l�̐ݒ�
b = abs(stereoParams.TranslationOfCamera2(1,1));
fku = stereoParams.CameraParameters1.IntrinsicMatrix(1,1);
u0_l = stereoParams.CameraParameters1.PrincipalPoint(1,1);
u0_r = stereoParams.CameraParameters2.PrincipalPoint(1,1);
v0_l = stereoParams.CameraParameters1.PrincipalPoint(1,2);

%% �Z�o
X = (u0_l) * b ./ disparityMap;
Y = (v0_l) * b ./ disparityMap;
Z = fku * b ./ disparityMap ;

%% ���s���摜��\��
ZRange = [0,1000];
figure
imshow(Z,ZRange);
title('Z Map');
colormap jet
colorbar
