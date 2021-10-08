function [x] = uppersol(A, b)
    if size(A,1) ~= size(A,2)
            disp('Error: The matrix is not square');
    
    elseif size(A,2) ~= size(b,1)
            disp('Error: Array dimensions do not match');
    
    elseif det(A) == 0
            disp('Error: Matrix A is not invertible');    
  
    else 
        for i = 1:size(A,1)
            for j = 1:size(A,2)
                if i < j
                    if A(i,j) ~= 0
                        disp('Error: The matrix is not upper triangular');
                    else
                        x = linsolve(A,b);
                    end
                end
            end
        end
    end
                 
        
                   
            
    
            