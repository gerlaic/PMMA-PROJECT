%   init.m
%   A script that automatically calculates all the data sheets we got

%   init
clc;clear all; close all;

%refDataFiles = [];
dir = 'TestData\';
output_dir = 'output\';
testDataFiles = {'Sample01_A_349kN_132ps_inside_rectangle_TD' ...
    'Sample01_A_354kN_132ps_TD' ...
    'Sample01_B_348kN_132ps_TD' ...
    'Sample01_C_352kN_132ps_TD' ...
    'Sample01_Center_354kN_132ps_TD' ...
    'Sample01_Center_357kN_132ps_inside rectangle_TD' ...
    'Sample01_D_348kN_132ps_TD' ...
    'Sample01_E_353kN_132ps_TD'};

testDataFiles = {'Sample01_A_349kN_132ps_inside_rectangle_TD'}; %override

% timestr = datestr(now,'yymmdd_HH_MM_SS');
% diary([output_dir,'log_',timestr,'.txt']);

for i = 1:size(testDataFiles,2)
    result = main(strcat(testDataFiles{i}),strcat('reference_',testDataFiles{i}),dir,output_dir);
    save(strcat(output_dir,testDataFiles{i},'_result.mat'),'result');
end

