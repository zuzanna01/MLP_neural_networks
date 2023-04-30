clear; clc; close all; format long;

%% Wczytanie danych
%dane treningowe
dataTrain = readtable("./train.csv");
dataTrain = dataTrain{:,:};

%dane testowe
dataTest = readtable("./test.csv");
dataTest = dataTest{:,:};