function CreateEnvironmentSetup(name, varargin)
    % CreateEnvironmentSetup
    % CreateEnvironmentSetup(name, varargin) creates a function called
    % name, which assigns the values of varargin
    [folder, name, ext] = fileparts(name);
    
    newline = [char(13) char(10)];
    functionContainer = 'function [';
    %% Outputs
    for i=1:length(varargin)
        if(i~=length(varargin))
            functionContainer = [functionContainer ...
                varargin{i} ', ']; %#ok
        else
            functionContainer = [functionContainer ...
                varargin{i}]; %#ok
        end
    end
    functionContainer = [functionContainer ...
        '] = '];
    %% Inputs
    
    functionContainer = [functionContainer ...
        name '()' newline]; 
    
    %% Assignments
    for i=1:length(varargin)
        functionContainer = [functionContainer ...
            varargin{i} ' =  ;' newline]; %#ok
    end
    
    
    functionContainer = [functionContainer ...
        'end' newline];
       
    filename = [folder filesep name ext];
    
    if exist(filename, 'file') ~= 0
        prompt = ['File ''' filename '''' ' already exists. Is it okay to overwrite? Y/N: ' ];
        x = input(prompt,'s');
        if(strcmpi(x,'y') == 1)
            FID = fopen(filename,'w');
            fprintf(FID, '%s', functionContainer);
            fclose(FID);
            SmartIndent(filename);
        end
    else
        FID = fopen(filename,'w');
        fprintf(FID, '%s', functionContainer);
        fclose(FID);
        SmartIndent(filename);
    end
        
end

