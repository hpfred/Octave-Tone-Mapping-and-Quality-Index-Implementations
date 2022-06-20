function runAll()
  ogPath = pwd;
  srcPath = strcat(ogPath,"\\src");
  
  fileList = dir(srcPath);
  
  for i=3:length(fileList)
    for j=1:4
      ToneMap(fileList(i).name,j)
    endfor  
  endfor
  
  
