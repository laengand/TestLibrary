function SmartIndent(filename)
    filename = which(filename);
    isOpen = matlab.desktop.editor.isOpen(filename);
    doc = matlab.desktop.editor.openDocument(filename);
    
    doc.smartIndentContents;
    doc.save;
    if(~isOpen)
        doc.close;
    end
end