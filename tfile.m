p = [1 2 3 4 5;2 4 6 8 10];
timestr = datestr(now,30);
fid = fopen([timestr, '.txt'],'w');
fprintf(fid,'%6.2f\t %6.2f\n',p);
fclose(fid);