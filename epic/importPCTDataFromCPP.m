function ret = importPCTDataFromCPP(filename, P, num_variables)
% loads PCT data from the C++ version of the EPIC library
% file format from C++:
% 1st row: var_name1, var_name2, var_name3, ...
% 2nd row: var_val1 , var_val2 , var_val3 , ...
% repeats 2nd row with different values for each column until end
% call initPCT() before calling this function.

    file = fopen(filename,'r'); % open the file to read

        % get and ignore first line of file
        %----------------------------------
        
    line = fgetl(file); % character line from file
    
        % measure number of value rows in file
        %-------------------------------------
        
    num_rows = 0; % number of rows in file
    
    while (fgetl(file) ~= -1)
        num_rows = num_rows + 1;
    end %while
    
    if(num_rows == 0) % report error of file not having any rows to read!
        error('importPCTDataFromCPP: given file is empty!');
    end %if
    
        % rewind file pointer to beginning and re-ignore the first line
        %--------------------------------------------------------------
    
    frewind(file);
    line = fgetl(file);
    
        % read values from file into arrays
        %----------------------------------
    
    all_values = zeros(num_rows, num_variables, P); % all of the data
    
    for r = 1:1:num_rows
        
        line = fgetl(file);
        columns = strsplit(line,',');
    
        for c = 1:1:num_variables
            
            all_values(r,c,:) = ( sscanf(cell2mat(columns(c)),'%f') )';
            
        end % for c
    
    end % for r
    
        % convert the data into pct type array
        %-------------------------------------
    
    pct_all_values(num_rows, num_variables) = pct(0,0,0); % matrix of the PCT data
    
    for r = 1:1:num_rows
    
        for c = 1:1:num_variables
            
            pct_all_values(r,c).val = all_values(r,c,:);
            
        end % for c
    
    end % for r
    
        % close file and return the PCT variable data taken from file
        %------------------------------------------------------------
        
    fclose(file);
    
    ret = pct_all_values;

end % function