function BuildDoc(deviceComm)

    [folder, ~, ~] = fileparts(mfilename('fullpath'));
    
    newline = [char(13) char(10)];
    m = methods(deviceComm, '-full');
    m = cellfun(@(c) strrep(c, 'RetVal ',''), m, 'UniformOutput', false);
    m = cellfun(@(c) strrep(c, 'TestLibrary.Communicator this, ',''), m, 'UniformOutput', false);
    m = cellfun(@(c) strrep(c, 'TestLibrary.Communicator this',''), m, 'UniformOutput', false);
    m = cellfun(@(c) strrep(c, 'scalar ',''), m, 'UniformOutput', false);
    assembly = deviceComm.GetType().Assembly;
    
%     members = deviceComm.GetType.DeclaredMembers;
    members = m;
    %% helpfiles
    helpfiles = {};
%     steps = double((members.Length-1)*2);
    steps = (length(members)*2);
    proc = 0;
    h = waitbar(proc/steps,['Building documentation so you don' '''' 't have to']);
    currentCmdId = '';
    cmdMembers = {};
    cellColumn = 1;
    cellRow = 1;
    STATE_FIND_FIRST = 0;
    STATE_FIND_CONSECUTIVE = 1;
    
    state = STATE_FIND_FIRST;
    i = 1;
    while i<=length(members)
        proc = proc + 1;
        waitbar(proc/steps,h);
        switch(state)
            case STATE_FIND_FIRST
%                 cmd = members.Get(i);
                cmd = members{i};
%                 cmdId = char(cmd.Name);
                cmdId = cmd;
                if(isValidCmd(cmdId))
                    cmdId = cmdId(1:5);
%                     member = char(members.Get(i).ToString);
                    member = members{i};
                    cellRow = 1;
                    cmdMembers{cellRow, cellColumn} =  member;
                    cellRow = cellRow + 1;
                    currentCmdId = cmdId;
                    state = STATE_FIND_CONSECUTIVE;
                end
                i=i+1;
                                
            case STATE_FIND_CONSECUTIVE
%                 cmd = members.Get(i);
                cmd = members{i};
%                 cmdId = char(cmd.Name);
                cmdId = cmd;
                if(isValidCmd(cmdId))
                    cmdId = cmdId(1:5);
                    
                    if(strcmpi(currentCmdId,cmdId))
%                         member = char(members.Get(i).ToString);
                        member = members{i};
                        cmdMembers{cellRow, cellColumn} =  member;
                        cellRow = cellRow + 1;
                        i=i+1;
                    else
                        state = STATE_FIND_FIRST;
                        cellColumn = cellColumn + 1;
                    end
                    
                else
                    state = STATE_FIND_FIRST;
                    cellColumn = cellColumn + 1;
                    i=i+1;
                end
               
        end
    end

    [rows,columns] = size(cmdMembers);
%     [~, I] = sort(cmdMembers(1,:));
%     
%     cmdMembers = cmdMembers(:,I);
    

for c=1:columns
    cmdCell = strsplit(cmdMembers{1,c}, {' ','(', ')'},'CollapseDelimiters',true);
    rtn = cmdCell{1};
    cmdName = cmdCell{2};
    title =  ['%% ' cmdName newline];
    syntax = ['%% Syntax' newline ...
        '% <html>' newline ...
        '% <font face="Consolas" color=#404040 size="9">' newline ...
        '% <ul style="list-style-type:none">' newline];
    
    descriptions = ['%% Description' newline];
        
        
    examples = ['%% Examples' newline ...
        '% <html>' newline ...
        '% <font face="Consolas" color=#404040 size="9">' newline ...
        '% <ul style="list-style-type:none">' newline];
    for r=1:rows
        if(isempty(cmdMembers{r,c}))
            continue
        end
        
        inputPara = strsplit(cmdMembers{r,c}, {'(', ')'},'CollapseDelimiters',true);
        inputPara = inputPara{2};
        
        examples = [examples ...
            '% <li> data = ' rtn '</li>' newline ...
            '% <li> replyData = ' 'deviceComm.' cmdName '(data)' '</li>' newline ...
            '% <li>' '_' '</li>' newline];
        
        syntax = [syntax ...
            '% <li>' rtn ' = ' 'deviceComm.' cmdName '(' inputPara ')</li>' newline];
    end
    
    syntax = [syntax ...
        '% </ul>' newline ...
        '% </font>' newline ...
        '% </html>' newline];
    examples = [ examples ...
        '% </ul>' newline ...
        '% </font>' newline ...
        '% </html>' newline];
    filename = [cmdName '.m'];
    helpfile = [title syntax descriptions examples];
    
    [fid,errmsg] = fopen([folder '\helpfiles\' filename ], 'w');
    fwrite(fid,helpfile);
    fclose(fid);
    
    if(isempty(helpfiles))
        helpfiles{1} = filename;
    else
        helpfiles{end + 1} = filename;
    end
end
        
        
%         inputPara = cmdCell{3};
        
   
    %% info.xml
    infoxml = ['<productinfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' newline ...
        'xsi:noNamespaceSchemaLocation="optional">' newline ...
        '<?xml-stylesheet type="text/xsl"href="optional"?>' newline ...
        '<matlabrelease>' version('-release') '</matlabrelease>' newline ...
        '<name>TestLibrary</name>' newline ...
        '<type>toolbox</type>' newline ...
        '<icon></icon>' newline ...
        '<help_location>html</help_location>' newline ...
        '</productinfo>' newline ];
    fid = fopen([pwd '\info.xml'], 'w');
    fwrite(fid,infoxml);
    fclose(fid);
    
    %% helptoc.xml
    class = char(deviceComm.ToString);
    cmdCell = cellfun(@(x) strsplit(x,{' ','(', ')'},'CollapseDelimiters',true), cmdMembers(1,:), 'UniformOutput', false);
    cmdName = cellfun(@(x) x{2},cmdCell, 'UniformOutput', false);
    
    
    classFunctions = cellfun(@classfunctionItem, cmdName , 'UniformOutput', false);
    classFunctions = strjoin(classFunctions, newline);
    
    documentation = '';
    documentation = [documentation ...
        '<?xml version=' '''' '1.0' '''' ' encoding="utf-8"?>' newline ...
        '<toc version="2.0">' newline ...
        newline ...
        '<tocitem target="testlibrary.html">TestLibrary' newline ...
        '    <tocitem target="classlist.html">' class newline ...
        classFunctions newline ...
        '    </tocitem>' newline ...
        '</tocitem>' newline ...
        newline ...
        '</toc>' newline];
    
    fid = fopen([folder '\html\helptoc.xml'], 'w');
    fwrite(fid,documentation);
    fclose(fid);
    for i=1:numel(helpfiles)
        proc = proc + 1;
        waitbar(proc/steps,h);
        publish([folder '\helpfiles\' helpfiles{i}], 'outputDir',[folder '\html\'],'evalCode',false );
    end
    addpath(folder);
    builddocsearchdb([folder '\html\']);
    waitbar(1,h);
    close(h)
end

function cfi = classfunctionItem(i)
    cfi = ['<tocitem target="' i '.html">' i '</tocitem>'];
end
function TF = isValidCmd(id)
    if(length(id)<5)
        TF = false;
        return 
    end
    id = id(1:5);
    if ~all(ismember(id, '0123456789ABCDEF'))
        TF = false;
        return 
    end
    if(id(1)~= 'C')
       TF = false;
        return 
    end
    TF = true;
end

