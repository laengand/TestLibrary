function SmartIndent(filename)
    filename = which(filename);
    doc = matlab.desktop.editor.openDocument(filename);
    doc.smartIndentContents;
    doc.save;
    doc.close;
end