clear; clc; close all; format long;
rng(0,'twister');

%% Wczytanie danych
%dane treningowe
dataTrain = readtable("./train.csv");
dataTrain = dataTrain{:,:};

%dane testowe
dataTest = readtable("./test.csv");
dataTest = dataTest{:,:};

%dane uczące 
inputTrainData = dataTrain(:,2:23);
inputTestData = dataTest(:,2:23);

%dane egzmainujące
outputTrainData = dataTrain(:,1);
outputTestData = dataTest(:,1);

%macierze wag inicjalizujemy 
%losowymi wartościami

inputNeurons = 22;
hiddenNeurons = 5;
outputNeurons = 1;

weightInputHidden = rand(hiddenNeurons, inputNeurons);
weightHiddenOutput = rand(outputNeurons, hiddenNeurons);

%parametry uczenia
w=[0 0]'; % punkt satrowy ?
w_b=w; % baias ?
K=1000; % ilość iteracji
eta=0.01; % wspólczynnik uczenia sieci
alpha=0.9; % współczynni bezwładności

%funkcja aktywacji 
% skok jednostkowy
function y = unit_step(x)
y = zeros(size(x));
y(x >= 0) = 1;
end

%RELU
function y = relu(x)
y = max(0, x);
end