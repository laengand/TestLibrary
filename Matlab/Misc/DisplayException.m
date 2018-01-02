function DisplayException(ex)
    disp('--')
    disp('Error:')
    disp(ex.message)
    disp('--')
    disp('Stack trace:')
    for k=1:length(ex.stack)
        disp([ex.stack(k).name ' Line: <a href="matlab: matlab.desktop.editor.openAndGoToLine(' '''' which(ex.stack(k).file) '''' ',' num2str(ex.stack(k).line) ');">' num2str(ex.stack(k).line) '</a>']);
    end
    disp('--')
end

