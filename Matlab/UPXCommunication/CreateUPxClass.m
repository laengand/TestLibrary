function CreateUPxClass(name)
    p = path;
    addpath('..\Misc\');
    newline = [char(13) char(10)];
    [folder, ~, ~] = fileparts(mfilename('fullpath'));
    cd(folder);
    
    % now get the path to the dot net library dll
    oldpath=pwd;
    cd(['..' filesep 'DotNetLibrary'])
    fullpath=pwd;
    cd(oldpath);
    PathToLibrary = [fullpath filesep];
    LibraryName = 'UPxComm.dll';
    
    try
        asmInfo = NET.addAssembly([PathToLibrary LibraryName]); %#ok
        import InstrumentDrivers.*
    catch ex
        error('Library or support file loading problem. Script halted')
    end
    %     upx = rsupv('USB::0x0AAD::0x004D::120003::INSTR', true, true);
    
    m = methods('rsupv', '-full');
    classContainer = ['classdef ' name newline]; % start of classDef
    classContainer = [classContainer ...
        'properties(Access = public)' newline ...
        'end' newline ...
        newline];
    
    classContainer = [classContainer ...
        'properties(Access = public)' newline ...
        'end' newline ...
        newline];
    
    classContainer = [classContainer ...
        'properties(Access = private)' newline ...
        'upxHandle;' newline ...
        'end' newline ...
        newline];
    
    classContainer = [classContainer ...
        'methods(Access = public)' newline ...      % start of methods(Access = public)
        '%% Constructor' newline ...
        'function self = ' name '(serialNr, idQuery, reset)' newline ...
        '[folder, ~, ~] = fileparts(mfilename(' '''' 'fullpath' '''' '));' newline ...
        'oldpath = pwd;' newline ...
        'cd(folder);' newline ...
        'cd([' '''' '..' '''' ' filesep ' '''' 'DotNetLibrary' '''' '])' newline ...
        'fullpath=pwd;' newline ...
        'cd(oldpath);' newline ...
        'PathToLibrary = [fullpath filesep];' newline ...
        'LibraryName =' '''' 'UPxComm.dll' '''' ';' newline ...
        'try' newline ...
        'asmInfo = NET.addAssembly([PathToLibrary LibraryName]);' newline ...
        'import InstrumentDrivers.*' newline ...
        'catch ex' newline ...
        'ex' newline ...
        'error(' '''' 'Library or support file loading problem. Script halted' '''' ') ' newline ...
        'end' newline ...
        'self.upxHandle = rsupv([' '''' 'USB::0x0AAD::0x004D::' '''' ' serialNr ' '''' '::INSTR' '''' '], idQuery, reset);' newline ...
        'end' newline];
    
    classFunctions = cellfun(@CreateFunction, m, 'UniformOutput', false);
    
    classFunctions = strjoin(classFunctions, '');
    classContainer = [classContainer newline ...
        classFunctions newline];
    
    classContainer = [classContainer ...
        'end' newline];                         % end of methods(Access = public)
    
    classContainer = [classContainer ...
        'end' newline];                         % end of classDef
    
    
    filename = [name '.m'];
    
    if exist(filename, 'file') ~= 0
        prompt = ['File ''' filename '''' ' already exists. Is it okay to overwrite? Y/N: ' ];
        x = input(prompt,'s');
        if(strcmpi(x,'y') == 1)
            FID = fopen(filename,'w');
            fprintf(FID, '%s', classContainer);
            fclose(FID);
            SmartIndent(filename);
        end
    else
        FID = fopen(filename,'w');
        fprintf(FID, '%s', classContainer);
        fclose(FID);
        SmartIndent(filename);
    end
    path(p);
end


function f = CreateFunction(c)
    newline = [char(13) char(10)];
    f = '';
    if(any(strfind(c, 'InstrumentDrivers.rsupv this')))
        c = strrep(c, ' RetVal ',' RetVal = ');
        c = strrep(c, 'scalar ','');
        c = strrep(c, 'logical ','');
        c = strrep(c, 'int16 ','');
        c = strrep(c, 'int32 ','');
        c = strrep(c, 'double ','');
        
        c = strrep(c, ']','] =');
        c = strrep(c, 'InstrumentDrivers.rsupv this, ','');
        c = strrep(c, 'InstrumentDrivers.rsupv this','');
        c = strrep(c, 'System.String ','');
        c = strrep(c, 'System.Object ','');
        c = strrep(c, 'System.Double[] = ','');
        c = strrep(c, 'Static ','');
        c = strrep(c, 'System.Type ','');
        
        additionalRtn = {};
        additionalPreSendFuncLine = [];
        additionalPostSendFuncLine = [];
        
        
        c = strsplit(c,{'=', '(',')'});
        if(numel(c)< 3)
            rtn = '';
            upxRtn = rtn;
            upxCmd = strtrim(c{1});
            para = strtrim(c{2});
        else
            rtn = strrep(strtrim(c{1}), '[' , '');
            rtn = strrep(rtn, ']' , '');
            rtn = strrep(rtn, '_', '');
            upxRtn = ['[' rtn '] = '];
            upxCmd = strtrim(c{2});
            para = strtrim(c{3});
        end
        
        para = strrep(para, '_', '');
        func = strrep(upxCmd, '_', '');
        
        upxPara = para;
        upxPara = strrep(upxPara, 'System.Text.StringBuilder ','');
        para = strsplit(para, ',');
                
        replacedParaIndex = cell2mat(cellfun(@(c) ~isempty(strfind(c, 'System.Text.StringBuilder')), para, 'UniformOutput', false));
        replacedPara = para(replacedParaIndex);
        
        for j=1:numel(replacedPara)
            paraToReplace = strtrim(strrep(replacedPara(j), 'System.Text.StringBuilder', ''));
            
            additionalRtn = [additionalRtn ...
                paraToReplace]; %#ok
            additionalPreSendFuncLine = [additionalPreSendFuncLine ...
                char(paraToReplace) ' = System.Text.StringBuilder(256);' newline]; %#ok
            additionalPostSendFuncLine = [additionalPostSendFuncLine ...
                char(paraToReplace) ' = char(' char(paraToReplace) '.ToString);' newline]; %#ok
        end
        
        para = strrep(para, 'System.Text.StringBuilder ','');
        para = strtrim(para);
        if(~strcmp(para(~replacedParaIndex),''))
            funcPara = ['self, ' strjoin(para(~replacedParaIndex), ', ')];
        else
            funcPara = 'self';
        end
        
        if(~isempty(additionalRtn))
            funcRtn = ['[' rtn ', ' strjoin(additionalRtn, ', ') '] = '];
        else
            funcRtn = ['[' rtn '] = '];
        end
        
        
        f = ['function ' funcRtn  func '(' funcPara ')' newline ...
            '% ' func newline ...
            '% ' funcRtn func '(' funcPara ')' newline ...
            additionalPreSendFuncLine ...
            upxRtn 'self.upxHandle.' upxCmd '(' upxPara ');' newline ...
            additionalPostSendFuncLine ...
            'end' newline];
    end
end

