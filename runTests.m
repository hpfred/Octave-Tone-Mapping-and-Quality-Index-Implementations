function runTests()
  pkg load statistics
  pkg load image
  
  ogPath = pwd;
  srcPath = strcat(ogPath,"\\src");
  resPath = strcat(ogPath,"\\results");
  qualPath = strcat(ogPath,"\\qualityResults");
  
  srcList = dir(srcPath);
  resList = dir(resPath);
  
  out = "";
  out2 = "";
  
  for i=3:length(srcList)
    name = strtok(srcList(i).name,".");
    hdrPath = strcat(srcPath,"\\",srcList(i).name);
    imgHDR = hdrimread(hdrPath);
    out = ["--",name,"--"];
    
    ltmPath = strcat(resPath,"\\",name,"-LTM.png");
    imgTM = imread(ltmPath);
    [Q, S, N, s_maps, s_local] = TMQI(imgHDR,imgTM);
    disp(Q);
    res = ["Quality Score: ",num2str(Q),"\nLDR Fidelity Score: ",num2str(S),"\nLDR Statistical Score: ", num2str(N)];
    out = strcat(out,"\n#LTM\n",res);
    
    mltmPath = strcat(resPath,"\\",name,"-MLTM.png");
    imgTM = imread(mltmPath);
    [Q, S, N, s_maps, s_local] = TMQI(imgHDR,imgTM);
    disp(Q);
    res = ["Quality Score: ",num2str(Q),"\nLDR Fidelity Score: ",num2str(S),"\nLDR Statistical Score: ", num2str(N)];
    out = strcat(out,"\n#MLTM\n",res);
    
    etmPath = strcat(resPath,"\\",name,"-ETM.png");
    imgTM = imread(etmPath);
    [Q, S, N, s_maps, s_local] = TMQI(imgHDR,imgTM);
    disp(Q);
    res = ["Quality Score: ",num2str(Q),"\nLDR Fidelity Score: ",num2str(S),"\nLDR Statistical Score: ", num2str(N)];
    out = strcat(out,"\n#ETM\n",res);
    
    metmPath = strcat(resPath,"\\",name,"-METM.png");
    imgTM = imread(metmPath);
    [Q, S, N, s_maps, s_local] = TMQI(imgHDR,imgTM);
    disp(Q);
    res = ["Quality Score: ",num2str(Q),"\nLDR Fidelity Score: ",num2str(S),"\nLDR Statistical Score: ", num2str(N)];
    out = strcat(out,"\n#METM\n",res);
    
    out = strcat(out,"\n\n");
    out2 = strcat(out2,out);
    
    name = strcat(qualPath,"\\",name,".txt");
    save("-text", name, "out");
  endfor
  
  fileName = "allResults.txt";
  filePath = strcat(qualPath,"\\",fileName);
  save("-text",filePath,"out2");