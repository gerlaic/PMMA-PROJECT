%   init.m
%   A script that automatically calculates all the data sheets we got

%   init
clc;clear all; close all;

%refDataFiles = [];
dir = 'TestData\';
testDataFiles = {'Sample01_A_354kN_132ps_TD.xlsx' ...
    'Sample01_B_348kN_132ps_TD.xlsx' ...
    'Sample01_C_352kN_132ps_TD.xlsx' ...
    'Sample01_Center_354kN_132ps_TD.xlsx' ...
    'Sample01_Center_357kN_132ps_inside rectangle_TD.xlsx' ...
    'Sample01_D_348kN_132ps_TD.xlsx' ...
    'Sample01_E_353kN_132ps_TD.xlsx'};


for i = 1:size(testDataFiles,2)
    result = main(strcat(dir,testDataFiles{i}),strcat(dir,'reference_',testDataFiles{i}));
    save(strcat(testDataFiles{i},'_result.mat'),'result');
end