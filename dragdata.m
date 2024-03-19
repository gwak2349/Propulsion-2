 function [alfa500,cl500,cd500,Remat,Cd0mat] = dragdata(filenames,astall)

% filenames contains the names of the different drag polars
% astall is the negative stall angle at a Reynolds number of 500,000
% Reynolds 50,000
[data]=readxfoil(filenames.Re50); 
ind50=find(data(:,1)<=0,1,'last');
cd050 = data(ind50,3);

% Reynolds 100,000
[data]=readxfoil(filenames.Re100); 
ind100=find(data(:,1)<=0,1,'last');
cd0100 = data(ind100,3);

% Reynolds 200,000
[data]=readxfoil(filenames.Re200); 
ind200=find(data(:,1)<=0,1,'last');
cd0200 = data(ind200,3);

% Reynolds 350,000
[data]=readxfoil(filenames.Re350); 
ind350=find(data(:,1)<=0,1,'last');
cd0350 = data(ind350,3);


% Reynolds 100,000
[data]=readxfoil(filenames.Re500); 
ind = find(data(:,1)<astall,1,'last');
ind500=find(data(:,1)<=0,1,'last');
alfa500 = data(ind:end,1);
cl500 = data(ind:end,2);
cd500 = data(ind:end,3);
ind500=find(data(:,1)<=0,1,'last');
cd0500 = data(ind500,3);

if length(fieldnames(filenames)) > 5 
% Reynolds 650,000
[data]=readxfoil(filenames.Re650); 
ind650=find(data(:,1)<=0,1,'last');
cd0650 = data(ind650,3);

% Reynolds 800,000
[data]=readxfoil(filenames.Re800); 
ind800=find(data(:,1)<=0,1,'last');
cd0800 = data(ind800,3);

% Reynolds 1,000,000
[data]=readxfoil(filenames.Re1000); 
ind1000=find(data(:,1)<=0,1,'last');
cd01000 = data(ind1000,3);


% put everything in a vector to calculate the Reynolds correction factor
Remat = [50 100 200 350 500 650 800 1000]*1000;
Cd0mat = [cd050 cd0100 cd0200 cd0350 cd0500 cd0650 cd0800 cd01000];
Remat = Remat(1:end-1);
Cd0mat=Cd0mat(1:end-1);

else % students have not added their xfoil files yet
    Remat = [50 100 200 350 500 ]*1000;
Cd0mat = [cd050 cd0100 cd0200 cd0350 cd0500];
end

Remat = Remat/500000;
Cd0mat = Cd0mat/(Cd0mat(5)); % assumes 500,000 is the 5th Reynolds number

% convert to radians !!
alfa500 = alfa500/180*pi;
