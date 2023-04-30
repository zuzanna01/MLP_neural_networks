%% Wczytanie danych
%Znajdź sobie plik Train
[filename, pathname] = uigetfile({'*.csv'},'File Selector');
fullpathname = strcat(pathname, filename);
dataTrain = readtable(fullpathname);
dataTrain = dataTrain{:,:};

%Znajdź sobie plik Test
[filename, pathname] = uigetfile({'*.csv'},'File Selector');
fullpathname = strcat(pathname, filename);
dataTest = readtable(fullpathname);
dataTest = dataTest{:,:};

%% Robienie histogramów ogólnoplikowych (wszystkie zera i jedynki z pliku)
figure(1);
subplot(1,2,1)
h=histogram(dataTrain(:,1));
title("Diagnozy zestaw treningowy")
ylim([0, max(h.Values)+1]);
xlim([-0.5, 1.5]);
xticks([0,1]);
subplot(1,2,2)
h = histogram(dataTest(:,1));
title("Diagnozy zestaw testowy")
ylim([0, max(h.Values)+1]);
xlim([-0.5, 1.5]);
xticks([0,1]);
yMax = [max(h.Values(1)), max(h.Values(2))];
yticks([0,yMax])

figure(2);
for ii = 2:23
    subplot(5,5,ii-1);
    sgtitle("zestaw treningowy")
    h = histogram(dataTrain(:,ii));
    title(sprintf('f %d', ii-1))
    ylim([0, max(h.Values)+1]);
    xlim([-0.5, 1.5]);
    xticks([0,1]);
    yMax = [max(h.Values(1)), max(h.Values(2))];
    yticks([0,yMax])
end

figure(3);
for ii = 2:23
    subplot(5,5,ii-1);
    sgtitle("zestaw testowy")
    h = histogram(dataTest(:,ii));
    title(sprintf('f %d', ii-1))
    ylim([0, max(h.Values)+1]);
    xlim([-0.5, 1.5]);
    xticks([0,1]);
    yMax = [max(h.Values(1)), max(h.Values(2))];
    yticks([0,yMax]);
end
