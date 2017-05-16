function ConvertTesttoolScript(matlabScriptName, deviceComm, testToolScriptPath)
% ConvertTesttoolScript 
% Script to convert a Testtool script into a corresponding matlab script
    newline = [char(13) char(10)];
    generatedScript = ['function ' matlabScriptName '(deviceComm)' newline];
    testToolScript = fopen(testToolScriptPath,'r');
    while ~feof(testToolScript)
        tlineOrig = fgets(testToolScript);
        addNewline = any(strfind(tlineOrig,newline));
        tlineOrig = strtrim(tlineOrig);
        if(~isempty(tlineOrig))
            tline = textscan(tlineOrig, '%s', 'Delimiter', sprintf(' '));
            tline = tline{1};
            
            if(strcmpi(tline{1}, 'pause') == 1)
                time = str2double(tline{2});
                generatedScript = [generatedScript ...
                    'pause(' num2str(time/1000) ')'];
            elseif(strncmpi(tline{1},'//', 2) == 1)
                generatedScript = [generatedScript ...
                    '%' tlineOrig(3:end)];
            elseif(all(ismember(tline{1}, '0123456789ABCDEF')))
                code = convertCmd(deviceComm, tlineOrig);
                generatedScript = [generatedScript ...
                    code];
            elseif(strncmpi(tline{1}, 'RealtimeEvent',length('RealtimeEvent')))
                inputPara = GetInputParameters(deviceComm, tlineOrig(length('RealtimeEvent')+1:end));
                generatedScript = [generatedScript ...
                    'deviceComm.SetRealTimeEventReceiver(' inputPara ');'];
            end
        end 
        if(addNewline)
           generatedScript = [generatedScript ...
               newline];
        end
    end
    generatedScript = [generatedScript ...
        'end' newline];
    fclose(testToolScript); 
    
    filename = [matlabScriptName '.m'];
    if exist(filename, 'file') ~= 0
        prompt = ['File ''' filename '''' ' already exists. Is it okay to overwrite? Y/N: ' ];
        x = input(prompt,'s');
        if(strcmpi(x,'y') == 1)
            matlabScript = fopen(filename,'w');
            fprintf(matlabScript, '%s', generatedScript);
            fclose(matlabScript);        
        end
    else
        matlabScript = fopen(filename,'w');
        fprintf(matlabScript, '%s', generatedScript);
        fclose(matlabScript);        
    end

    matlabScript = fopen([matlabScriptName '.m'],'w');
    fprintf(matlabScript , '%s', generatedScript);
    fclose(matlabScript); 
    SmartIndent(matlabScriptName);
end

function code = convertCmd(deviceComm,tlineOrig)
    tline = textscan(tlineOrig, '%s', 'Delimiter', sprintf(' '));
    tline = tline{1};
    cmdId = tline{1};
    commentIdx = strfind(tlineOrig,'//');
    
    if(~isempty(commentIdx))
        input = strtrim(tlineOrig(1:commentIdx-1));
    else
        input = strtrim(tlineOrig(1:end));
    end

    input = GetInputParameters(deviceComm,input);
    
    name = '';
    for i=0:deviceComm.GetType().GetMembers().Length
        name = char(deviceComm.GetType().GetMembers().Get(i).Name);
        if(strcmp(name(2:5),cmdId))
            break;
        end
    end
    
    cmd = [name '(' input ');'];
    comment = '';
    if(~isempty(commentIdx))
        comment = ['%' tlineOrig(commentIdx+2:end)];
    end
    code = ['deviceComm.' cmd comment];
end

function input = GetInputParameters(deviceComm, inputSting)
    input = textscan(inputSting, '%s', 'Delimiter', sprintf(','));
    cmd = input{1}{1}(1:4);
    input{1}{1}(1:4) = '';
    input = strtrim(input{1});
    
    for i=1:numel(input)
        % Convert hex numbers
        if(strncmpi(input{i}, '0x',2) == 1)
            input{i} = ['hex2dec(' '''' input{i}(3:end) '''' ')'];
        elseif(any(strfind(input{i}, '"')))
            input{i} = strrep(input{i}, '"','''');
        % Convert enums
        elseif(~all(ismember(input{i}, '0123456789ABCDEF+-.')))
            libName = char(deviceComm.GetType().Assembly.ToString());
            p = properties(['C' cmd '.Data']);
            p = strrep(p,'internal','');
            if(isempty(p))
                error(['Command ''' cmd  '''' ' not defined in ''' libName '''']);
            end
            enum = ['C' cmd '.e' p{i}];
            t = deviceComm.GetType().Assembly;
            t = t.GetType(System.String(enum));
            if(isempty(t))
                error(['Enum ' enum ' not defined in ''' libName '''']);
            end
            eName = '';
            j = 0;
            for j=0:t.DeclaredMembers.Length-1 %c# indexing
                eName = char(t.DeclaredMembers.Get(j).Name);
                temp = regexprep(input{i},' ',''); 
                temp = regexprep(temp,'[^0-9a-zA-Z]+',''); 
                
                if(any(strfind(lower(eName), lower(temp))))
                    break;
                elseif (j == t.DeclaredMembers.Length-1)
                    error(['Enum ''' temp ''' not defined in ''' libName ''''] )
                end
            end
                       
            input{i} = ['C' cmd '.e' p{i} '.' eName];
        end
    end
    input = strjoin(input, ', ');
end
