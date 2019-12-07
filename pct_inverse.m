% This code is to calculate the inverse of the matrix
% The version is for numerical calculation, need develop to PCT version
initPCT(3,3)

a11 = pct(3,0.3,1);
a22 = pct(5,0.5,1);
b11 = pct(1,0,1);

a = [a11 10;2 a22];

% Find dimensions of input matrix
[r,c] = size(a);

% If input matrix is not square, stop function
if r ~= c
    disp('Only Square Matrices, please')
    b = [];
    return
end

% Target identity matrix to be transformed into the output 
% inverse matrix

b = [b11 0;0 b11];

% The following code actually performs the matrix inversion by working
% on each element of the input 
for j = 1 : r
    for i = j : r
        %if a(i,j) ~= 0
            for k = 1 : r
                s = a(j,k); a(j,k) = a(i,k); a(i,k) = s;
                s = b(j,k); b(j,k) = b(i,k); b(i,k) = s;
            end
            t = 1/a(j,j);
            for k = 1 : r
                a(j,k) = a(j,k)*t;
                b(j,k) = b(j,k)*t;
            end
            for L = 1 : r
                if L ~= j
                    t = -a(L,j);
                    for k = 1 : r
                        a(L,k) = a(L,k) + a(j,k)*t;
                        b(L,k) = b(L,k) + b(j,k)*t;
                    end
                end
            end            
        %end
        break
    end
    % Display warning if a row full of zeros is found
%     if a(i,j) == 0
%         disp('Warning: Singular Matrix')
%         b = 'error';
%         return
%     end
end

%plot
b11p = resample(b(1,1),10000);
figure(1)
histogram(b11p)
% Show the evolution of the input matrix, so that we can 
% confirm that it became an identity matrix.
% a
