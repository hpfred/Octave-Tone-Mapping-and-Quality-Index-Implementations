function out = ToneMap(name, op)
  pkg load image
  
  ogPath = pwd;
  srcPath = strcat(ogPath,"\\src");
  resPath = strcat(ogPath,"\\results");
  qualPath = strcat(ogPath,"\\qualityResults");
  
  filePath = strcat(srcPath,"\\",name);
  img = hdrimread(filePath);
  
  ##lum = lum(img);
  lumRGB(:,:,1) = img(:,:,1)*0.2126; #0.299  #0.27
  lumRGB(:,:,2) = img(:,:,2)*0.7152; #0.587  #0.67
  lumRGB(:,:,3) = img(:,:,3)*0.0722; #0.114  #0.06
  lum = lumRGB(:,:,1) + lumRGB(:,:,2) + lumRGB(:,:,3);
  
  switch op
    ##Log
    case 1 #LTM
      opName = "LTM";
      lumMax = max(lum(:));
      Ld = log10(1+lum) / log10(1+lumMax);
    case 2 #MLTM
      opName = "MLTM";
      for i=1:3
        lumVal = lumRGB(:,:,i);
        lumMax = max(lumVal(:));
        Ld(:,:,i) = lumRGB(:,:,i) / (log10(1+lumMax(:)));
      endfor
      
    ##Exp
    case 3 #ETM
      opName = "ETM";
      delta = 1e-6;
      imgDelta = log(img + delta);
      Lwa = exp(mean(imgDelta(:)));
      Ld = 1 - exp(-1*(lum/Lwa));
    case 4 #METM
      opName = "METM";
      delta = 1e-6;
      for i=1:3
        imgDelta = log(img(:,:,i) + delta);
        Lwa = exp(mean(imgDelta(:)));
        Ld(:,:,i) = 1 - exp(-1*(lumRGB(:,:,i)/Lwa));
      endfor
    otherwise
      disp("Operator not available");
  endswitch
  
  ##imgOut = ChangeLuminance(img, lum, Ld);
  col = size(img, 3);
  imgOut = zeros(size(img));
  
  if(op==1 || op==3)
    for i=1:col
      imgOut(:,:,i) = (img(:,:,i) .* Ld) ./ lum;
    endfor
  elseif(op==2 || op==4)
    for i=1:col
      imgOut(:,:,i) = (img(:,:,i) .* Ld(:,:,i)) ./ lumRGB(:,:,i);
    endfor
  endif
  
  imgOut = RemoveSpecials(imgOut);
  
  #figure();
  #imshow(imgOut);
  
  name = strtok(name,".");
  filePath = strcat(resPath,"\\",name);
  imwrite(imgOut,[filePath,"-",opName,".png"]);
  
  
      
    
