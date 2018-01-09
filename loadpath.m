addpath(genpath(pwd));
% Example :  
% (http://nlp.stanford.edu/IR-book/html/htmledition/evaluation-of-clustering-1.html)
A = [1 1 1 1    2 2 2 2    3 3 3 3];
B = [1 1 1 1    1 2 2 2    3 3 3 3];
nmi_web(A,B) 

% ans =  0.3646