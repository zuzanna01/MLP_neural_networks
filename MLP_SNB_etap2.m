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

weightInputHidden = -0.01 + (0.02)*rand(hiddenNeurons, inputNeurons); 
weightHiddenOutput = -0.01 + (0.02)*rand(outputNeurons, hiddenNeurons);

%parametry uczenia
K=10000; % liczba iteracji
eta=0.01; % wspólczynnik uczenia sieci
alpha=0.9; % współczynni bezwładności

%uczenie sieci
for i = 1:K

    n =randi([1,22]);
    x = inputTrainData(n,:);

    % oblicz pobudzenie neuronów w warstwie ukrytej
    hiddenInput = weightInputHidden * x';
    biasHidden = -0.1 + (0.2)*rand(hiddenNeurons, 1);
    hiddenOutput = ReLU(hiddenInput + biasHidden);

    % oblicz pobudzenie neuronów w warstwie wyjściowej
    outputInput = weightHiddenOutput * hiddenOutput;
    biasOutput = -0.1 + (0.2)*rand(outputNeurons, 1);
    outputOutput = stepFunction(outputInput + biasOutput);

    % obliczanie błędu
    d = outputTrainData(n); % d - target - diagnoza lekarza
    outputError = d - outputOutput;
    disp(outputError);
   
    % warstwy wyjściowej
    outputDelta = outputError;
        
    % warstwy ukrytej
    hiddenDelta = (weightHiddenOutput' * outputDelta).*relu_derivative(hiddenInput) ;

    % Propagacja wsteczna błędu
    % Aktualizacja wag warstwy wyjściowej
    weightHiddenOutput = weightHiddenOutput + eta * outputDelta * hiddenOutput';
        
    % Aktualizacja wag warstwy ukrytej
    weightInputHidden = weightInputHidden + (eta * hiddenDelta) * x;

end

right_diagnosis =0;
%walidacja
for i = 1:size(inputTestData,1)
    
    % Pobieranie i-tego wiersza danych testowych
    x = inputTestData(i,:);
    
    % Obliczanie pobudzenia neuronów warstwy ukrytej i wyjściowej
    hiddenLayerInput = x * weightInputHidden';
    hiddenLayerOutput = ReLU(hiddenLayerInput);
    outputLayerInput = hiddenLayerOutput * weightHiddenOutput';
    outputLayerOutput = stepFunction(outputLayerInput);
    
    % Wyświetlanie prognozy wyjściowej i rzeczywistej wartości wyjściowej
    disp(['Prognozowane wyjście: ' num2str(outputLayerOutput) ', Rzeczywiste wyjście: ' num2str(outputTestData(i))]);

    if (outputLayerOutput == outputTestData(i)) 
        right_diagnosis = right_diagnosis+1;
    end
end

disp(['Poprawne diagnizy: ',num2str(right_diagnosis/size(inputTestData,1)*100),' %']);

%funkcja aktywacji 
% skok jednostkowy
function y = stepFunction(x)
y = zeros(size(x));
y(x > 0) = 1;
end

%RELU
function y = ReLU(x)
y = max(0, x);
end

% pochodna ReLU 
function d = relu_derivative(x)
d = x >= 0;  % wartości większe od zera mają pochodną równą 1
d(x <= 0) = 0;  % wartości mniejsze lub równe zeru mają pochodną równą 0
end