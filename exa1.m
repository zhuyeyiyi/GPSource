function cnt = exa1() 
	
	clc;
	clear all;
	close all;

	count0 = 0;
	count1 = 0;
	count2 = 0;
	count3 = 0;
	count4 = 0;
	count5 = 0;
	count6 = 0;
	count7 = 0;
	count8 = 0;
	
	param0 = [0 0]';
	param1 = [0 0]';
	param2 = [0 0]';	
	param3 = [0 0]';
	param4 = [0 0]';
	param5 = [0 0]';
	param6 = [0 0]';
	param7 = [0 0]';
	param8 = [0 0]';
	
	
	step = 0.5;
	rate = 0.24;	%solution range:*alpha-beta<gamma
	gamma = 0.8;	%Intercept

	limit = 0;		%
	
	options = zeros(5);
	options(5) = 1;
	
	target = 0;
	
	% for beta = -30:step:10			% for beta = -0.6:0.05:0.2
		% for alpha =  -70:step:20		% for alpha =  -2:0.05:1

		
			% if(rate*alpha-beta>gamma)
				% continue;
			% end
			
			% A1=[-2 alpha;19 beta];
			% A2=[-4 alpha;-1 beta];
			
			% setlmis([]);
			
			% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
			% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
			 % W=lmivar(1,[2 1]);				% W

			% lmiterm([-1 1 1 V1],1/2,1,'s');	% 0<V1:V1
		
			% lmiterm([-2 1 1 V2],1/2,1,'s');	% 0<V2:V2 
			
			% lmiterm([-3 1 1  W],1,1);		% 0<W:W

			% lmiterm([4 1 1 -V1],1,A1,'s');	% V1*A1+A1'*V1'+W<0:V1*A1+A1*V1'
			% lmiterm([4 1 1   W],1,1);		% V1*A1+A1*V1'+W<0:W

			% lmiterm([5 1 1 -V2],1,A2,'s');	% V2*A2+A2'*V2'+W<0:V2*A2+A2*V2'
			% lmiterm([5 1 1   W],1,1);		% V2*A2+A2*V2'+W<0:W

			% lmiterm([6 1 1 -V1],1,A2,'s');	% V1*A2+A2'*V1'-W<0:V1*A2+A2'*V2'
			% lmiterm([6 1 1   W],-1,1);		% V1*A2+A2'*V1'-W<0:-W

			% lmiterm([7 1 1 -V2],1,A1,'s');	% V2*A1+A1'*V2'-W<0:V2*A1+A1'*V2'
			% lmiterm([7 1 1   W],-1,1);		% V2*A1+A1'*V2'-W<0:-W
			
			% lmisys=getlmis;
			% [tmin,xfeas]=feasp(lmisys,options,target);


			% if tmin<0
				% param0 = [param0 [alpha beta]'];
				% count0 = count0 + 1;
			% end
			
		% end
	% end
	% [m n] = size(param0);
	% param0 = param0(:,2:n);
	% timestr = datestr(now,30);
	% fid = fopen([timestr,'_param0.txt'],'w');		
	% fprintf(fid,'%6.2f\t %6.2f\n',param0);
	% fclose(fid);
	% plot(param0(1,:),param0(2,:),'.','markersize',5);
	% hold on;

	
	
	
		
	for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		for alpha =  -70:step:20		% for alpha =  -2:0.05:1
		
		if(rate*alpha-beta>gamma)
			continue;
		end
		
		A1=[-2 alpha;19 beta];
		A2=[-4 alpha;-1 beta];
		
		setlmis([]);
		
		V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		
		lamda12 = lmivar(3,[6 7;8 9]);
		lamda21 = lmivar(3,[10 11;12 13]);


		lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 

		lmiterm([ 3 1 1 V1],A2',1,'s');
		lmiterm([-3 1 1 lamda12],1/2,1,'s');

		lmiterm([ 4 1 1 V2],A1',1,'s');
		lmiterm([-4 1 1 lamda21],1/2,1,'s');
		
		lmiterm([5 1 1 V1],A1',1,'s');
		lmiterm([5 1 2  lamda12],1/2,1);
		lmiterm([5 1 2 -lamda21],1/2,1);
		lmiterm([5 2 1 -lamda12],1/2,1);
		lmiterm([5 2 1  lamda21],1/2,1);
		lmiterm([5 2 2 V2],A2',1,'s');
		
		lmisys=getlmis;
		[tmin,xfeas]=feasp(lmisys,options,target);
		
		if tmin<0
			param1 = [param1 [alpha beta]'];
			count1 = count1 + 1;
			hold on;
		end

		end
	end

	[m n] = size(param1);
	param1 = param1(:,2:n);
	timestr = datestr(now,30);
	fid = fopen([timestr,'_param1.txt'],'w');		
	fprintf(fid,'%6.2f\t %6.2f\n',param1);
	fclose(fid);
	plot(param1(1,:),param1(2,:),'o','markersize',10);
	hold on;
	
	

	
	
	
	% for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		% for alpha =  -70:step:20		% for alpha =  -2:0.05:1
		
		% if(rate*alpha-beta>gamma)
			% continue;
		% end
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
		
		% setlmis([]);

		% P=lmivar(1,[2 1]);
		
		% lmiterm([-1 1 1 P],1,1);

		% lmiterm([2 1 1 P],1,A1,'s');
		% lmiterm([3 1 1 P],1,A2,'s');

		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys,options,target);
		
		% if tmin<0
			% param2 = [param2 [alpha beta]'];
			% count2 = count2 + 1;
			% hold on;
		% end

		% end
	% end

	% [m n] = size(param2);
	% param2 = param2(:,2:n);
	% timestr = datestr(now,30);
	% fid = fopen([timestr,'_param2.txt'],'w');		
	% fprintf(fid,'%6.2f\t %6.2f\n',param2);
	% fclose(fid);
	% plot(param2(1,:),param2(2,:),'rs','markersize',5);
	% hold on;

	
	
	% for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		% for alpha =  -70:step:20		% for alpha =  -2:0.05:1

		% if(rate*alpha-beta>gamma)
			% continue;
		% end
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
		
		% setlmis([]);
		
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		% E1=lmivar(3,5+[1 2;3 4]);
		% E2=lmivar(3,9+[1 2;3 4]);
		
		% lamda12 = lmivar(3,13+[1 2 3 4;5 6 7 8;9 10 11 12;13 14 15 16]);
		% lamda21 = lmivar(3,29+[1 2 3 4;5 6 7 8;9 10 11 12;13 14 15 16]);

		% lamda12_11 = lmivar(3,13+[1 2;5 6]); 
		% lamda12_12 = lmivar(3,13+[3 4;7 8]);
		% lamda12_21 = lmivar(3,13+[9 10;13 14]);
		% lamda12_22 = lmivar(3,13+[11 12;15 16]);

		% lamda21_11 = lmivar(3,29+[1 2;5 6]); 
		% lamda21_12 = lmivar(3,29+[3 4;7 8]);
		% lamda21_21 = lmivar(3,29+[9 10;13 14]);
		% lamda21_22 = lmivar(3,29+[11 12;15 16]);

		
		% lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 

		% lmiterm([ 3 1 1  V1],A2',1,'s');
		% lmiterm([ 3 1 1  E2],A1',-1,'s');
		% lmiterm([ 3 1 2  E1],A1',-1);
		% lmiterm([ 3 1 2 -E2],1,1);
		% lmiterm([ 3 2 1 -E1],-1,A1);
		% lmiterm([ 3 2 1  E2],1,1);
		% lmiterm([ 3 2 2  E1],1,1,'s');	
		% lmiterm([-3 1 1  lamda12_11],1/2,1,'s');
		% lmiterm([-3 1 2  lamda12_12],1/2,1);
		% lmiterm([-3 1 2 -lamda12_21],1/2,1);
		% lmiterm([-3 2 1  lamda12_21],1/2,1);
		% lmiterm([-3 2 1 -lamda12_12],1/2,1);
		% lmiterm([-3 2 2  lamda12_22],1/2,1,'s');


		% lmiterm([ 4 1 1  V2],A1',1,'s');
		% lmiterm([ 4 1 1  E2],A2',-1,'s');
		% lmiterm([ 4 1 2  E1],A2',-1);
		% lmiterm([ 4 1 2 -E2],1,1);
		% lmiterm([ 4 2 1 -E1],-1,A2);
		% lmiterm([ 4 2 1  E2],1,1);
		% lmiterm([ 4 2 2  E1],1,1,'s');				
		% lmiterm([-4 1 1  lamda21_11],1/2,1,'s');
		% lmiterm([-4 1 2  lamda21_12],1/2,1);
		% lmiterm([-4 1 2 -lamda21_21],1/2,1);
		% lmiterm([-4 2 1  lamda21_21],1/2,1);
		% lmiterm([-4 2 1 -lamda21_12],1/2,1);
		% lmiterm([-4 2 2  lamda21_22],1/2,1,'s');


		
		% lmiterm([5 1 1 V1],A1',1,'s');
		% lmiterm([5 1 1 E2],A1',-1,'s');
		% lmiterm([5 1 2 E1],A1',-1);
		% lmiterm([5 1 2 -E2],1,1);
		% lmiterm([5 2 1 -E1],-1,A1);
		% lmiterm([5 2 1 E2],1,1);
		% lmiterm([5 2 2 E1],1,1,'s');
		
		% lmiterm([5 3 3 V2],A2',1,'s');
		% lmiterm([5 3 3 E2],A2',-1,'s');
		% lmiterm([5 3 4 E1],A2',-1);
		% lmiterm([5 3 4 -E2],1,1);
		% lmiterm([5 4 3 -E1],-1,A2);
		% lmiterm([5 4 3 E2],1,1);
		% lmiterm([5 4 4 E1],1,1,'s');

		
		% lmiterm([5 1 3  lamda12_11],1/2,1);
		% lmiterm([5 1 3 -lamda21_11],1/2,1);
		% lmiterm([5 1 4  lamda12_12],1/2,1);		
		% lmiterm([5 1 4 -lamda21_21],1/2,1);
		% lmiterm([5 2 3  lamda12_21],1/2,1);
		% lmiterm([5 2 3 -lamda21_12],1/2,1);
		% lmiterm([5 2 4  lamda12_22],1/2,1);
		% lmiterm([5 2 4 -lamda21_22],1/2,1);

		% lmiterm([5 3 1  lamda21_11],1/2,1)
		% lmiterm([5 3 1 -lamda12_11],1/2,1)
		% lmiterm([5 3 2  lamda21_12],1/2,1)
		% lmiterm([5 3 2 -lamda12_21],1/2,1)
		% lmiterm([5 4 1  lamda21_21],1/2,1)
		% lmiterm([5 4 1 -lamda12_12],1/2,1)		
		% lmiterm([5 4 2  lamda21_22],1/2,1)
		% lmiterm([5 4 2 -lamda12_22],1/2,1)
				
		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys,options,target);
		
		% if tmin<0
			% param3 = [param3 [alpha beta]'];
			% count3 = count3 + 1;
			% hold on;
		% end

		% end
	% end

	
	% [m n] = size(param3);
	% param3 = param3(:,2:n);
	% timestr = datestr(now,30);
	% fid = fopen([timestr,'_param3.txt'],'w');			
	% fprintf(fid,'%6.2f\t %6.2f\n',param3);
	% fclose(fid);
	% plot(param3(1,:),param3(2,:),'s','markersize',6);
	% hold on;

	






	
	
	
	
	% for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		% for alpha =  -70:step:20		% for alpha =  -2:0.05:1

		% if(rate*alpha-beta>gamma)
			% continue;
		% end		

		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
			
		% setlmis([]);
			
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		% E2=lmivar(3,[6 7;8 9]);			% E2
		% E1=lmivar(3,[10 11;11 12]);		% E1
		
		
		% lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 
		
		% lmiterm([3 1 1 E1],1,1);			% E1<0:E1
		
		% lmiterm([4 1 1 -V1],4,A1,'s');		% 4*V1'*A1+4*A1'*V1
		% lmiterm([4 1 1  E1],A1',-A1,'s');	% -A1'*E1*A1
		% lmiterm([4 1 1  E2],A1',-2,'s');	% -2E2'*A1-2A1'*E2
		% lmiterm([4 1 2 -E2],1,1);			% E2'
		% lmiterm([4 2 1  E2],1,1);			% E2
		% lmiterm([4 2 2  E1],1/2,1);			% E1
		
		% lmiterm([5 1 1 -V1],4,A2,'s');		% 4*V1*A2+4*A2'*V1
		% lmiterm([5 1 1  E1],A2',-A1,'s');	% -A1'*E1*A2
		% lmiterm([5 1 1  E2],A1',-2,'s');	% -2E2'*A1-2A1'*E2
		% lmiterm([5 1 2 -E2],1,1);			% E2'
		% lmiterm([5 2 1  E2],1,1);			% E2
		% lmiterm([5 2 2  E1],1/2,1);			% E1
		
		% lmiterm([6 1 1 -V2],4,A1,'s');		% 4*V2*A1+4*A1'*V2
		% lmiterm([6 1 1  E1],A1',-A2,'s');	% -A2'*E1*A1
		% lmiterm([6 1 1  E2],A2',-2,'s');	% -E2'*A2-A2'*E2
		% lmiterm([6 1 2 -E2],1,1);			% E2'
		% lmiterm([6 2 1  E2],1,1);			% E2
		% lmiterm([6 2 2  E1],1/2,1);			% E1
		
		% lmiterm([7 1 1 -V2],4,A2,'s');		% 4*V2*A2+4*A2'*V2
		% lmiterm([7 1 1  E1],A2',-A2,'s');	% -A2'*E1*A2
		% lmiterm([7 1 1  E2],A2',-2,'s');	% -2E2'*A2-2A2'*E2
		% lmiterm([7 1 2 -E2],1,1);			% E2'
		% lmiterm([7 2 1  E2],1,1);			% E2
		% lmiterm([7 2 2  E1],1/2,1);			% E1
			
		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys,options,target);
		
		% if tmin<0
			% param4 = [param4 [alpha beta]'];
			% count4 = count4 + 1;
			% hold on;
		% end
			
		
		% end
	% end	
	
	
	% [m n] = size(param4);
	% param4 = param4(:,2:n);
	% timestr = datestr(now,30);
	% fid = fopen([timestr,'_c1param4.txt'],'w');			
	% fprintf(fid,'%6.2f\t %6.2f\n',param4);
	% fclose(fid);
	% plot(param4(1,:),param4(2,:),'s','markersize',6);
	% hold on;





	% for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		% for alpha =  -70:step:20		% for alpha =  -2:0.05:1

		% if(rate*alpha-beta>gamma)
			% continue;
		% end
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
		
		% setlmis([]);
		
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		% E1=lmivar(3,5+[1 2;2 4]);		% E1=lmivar(3,5+[1 2;3 4]);
		% E2=lmivar(3,9+[1 2;3 4]);
		
		% lamda12 = lmivar(3,13+[1 2 3 4;5 6 7 8;9 10 11 12;13 14 15 16]);
		% lamda21 = lmivar(3,29+[1 2 3 4;5 6 7 8;9 10 11 12;13 14 15 16]);

		% lamda12_11 = lmivar(3,13+[1 2;5 6]); 
		% lamda12_12 = lmivar(3,13+[3 4;7 8]);
		% lamda12_21 = lmivar(3,13+[9 10;13 14]);
		% lamda12_22 = lmivar(3,13+[11 12;15 16]);

		% lamda21_11 = lmivar(3,29+[1 2;5 6]); 
		% lamda21_12 = lmivar(3,29+[3 4;7 8]);
		% lamda21_21 = lmivar(3,29+[9 10;13 14]);
		% lamda21_22 = lmivar(3,29+[11 12;15 16]);

		
		% lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 
		
		% lmiterm([ 3 1 1 E1],1,1);			% E1<0

		% lmiterm([ 4 1 1  V1],A2',4,'s');
		% lmiterm([ 4 1 1  E1],A1',-A2,'s');
		% lmiterm([ 4 1 1  E2],A1',-2,'s');
		% lmiterm([ 4 1 2 -E2],1,1);
		% lmiterm([ 4 2 1  E2],1,1);
		% lmiterm([ 4 2 2  E1],1,1/2);	
		% lmiterm([-4 1 1  lamda12_11],1/2,1,'s');
		% lmiterm([-4 1 2  lamda12_12],1/2,1);
		% lmiterm([-4 1 2 -lamda12_21],1/2,1);
		% lmiterm([-4 2 1  lamda12_21],1/2,1);
		% lmiterm([-4 2 1 -lamda12_12],1/2,1);
		% lmiterm([-4 2 2  lamda12_22],1/2,1,'s');


		% lmiterm([ 5 1 1  V2],A1',4,'s');
		% lmiterm([ 5 1 1  E1],A2',-A1,'s');
		% lmiterm([ 5 1 1  E2],A2',-2,'s');
		% lmiterm([ 5 1 2 -E2],1,1);
		% lmiterm([ 5 2 1  E2],1,1);
		% lmiterm([ 5 2 2  E1],1,1/2);	
		% lmiterm([-5 1 1  lamda21_11],1/2,1,'s');
		% lmiterm([-5 1 2  lamda21_12],1/2,1);
		% lmiterm([-5 1 2 -lamda21_21],1/2,1);
		% lmiterm([-5 2 1  lamda21_21],1/2,1);
		% lmiterm([-5 2 1 -lamda21_12],1/2,1);
		% lmiterm([-5 2 2  lamda21_22],1/2,1,'s');


		
		% lmiterm([ 6 1 1  V1],A1',4,'s');
		% lmiterm([ 6 1 1  E1],A1',-A1,'s');
		% lmiterm([ 6 1 1  E2],A1',-2,'s');		
		% lmiterm([ 6 1 2 -E2],1,1);		
		% lmiterm([ 6 2 1  E2],1,1);		
		% lmiterm([ 6 2 2  E1],1,1/2);
		
		% lmiterm([ 6 3 3  V2],A2',4,'s');
		% lmiterm([ 6 3 3  E1],A2',-A2,'s');
		% lmiterm([ 6 3 3  E2],A2',-2,'s');		
		% lmiterm([ 6 3 4 -E2],1,1);	
		% lmiterm([ 6 4 3  E2],1,1);
		% lmiterm([ 6 4 4  E1],1,1/2);

		
		% lmiterm([6 1 3  lamda12_11],1/2,1);
		% lmiterm([6 1 3 -lamda21_11],1/2,1);
		% lmiterm([6 1 4  lamda12_12],1/2,1);		
		% lmiterm([6 1 4 -lamda21_21],1/2,1);
		% lmiterm([6 2 3  lamda12_21],1/2,1);
		% lmiterm([6 2 3 -lamda21_12],1/2,1);
		% lmiterm([6 2 4  lamda12_22],1/2,1);
		% lmiterm([6 2 4 -lamda21_22],1/2,1);

		% lmiterm([6 3 1  lamda21_11],1/2,1)
		% lmiterm([6 3 1 -lamda12_11],1/2,1)
		% lmiterm([6 3 2  lamda21_12],1/2,1)
		% lmiterm([6 3 2 -lamda12_21],1/2,1)
		% lmiterm([6 4 1  lamda21_21],1/2,1)
		% lmiterm([6 4 1 -lamda12_12],1/2,1)		
		% lmiterm([6 4 2  lamda21_22],1/2,1)
		% lmiterm([6 4 2 -lamda12_22],1/2,1)
				
		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys,options,target);
		
		% if tmin<0
			% param5 = [param5 [alpha beta]'];
			% count5 = count5 + 1;
			% hold on;
		% end

		% end
	% end

	
	% [m n] = size(param5);
	% param5 = param5(:,2:n);
	% timestr = datestr(now,30);
	% fid = fopen([timestr,'_param5.txt'],'w');			
	% fprintf(fid,'%6.2f\t %6.2f\n',param5);
	% fclose(fid);
	% plot(param5(1,:),param5(2,:),'s','markersize',6);
	% hold on;

	












	% for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		% for alpha =  -70:step:20		% for alpha =  -2:0.05:1

		% if(rate*alpha-beta>gamma)
			% continue;
		% end
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
		
		% setlmis([]);
		
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		% E1=lmivar(3,5+[1 2;3 4]);
		% E2=lmivar(3,9+[1 2;3 4]);

		% lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 
		
		% lmiterm([ 3 1 1  V1],A1',1,'s');
		% lmiterm([ 3 1 1  E2],A1',-1,'s');
		% lmiterm([ 3 1 2 -E2],1,1);
		% lmiterm([ 3 1 2  E1],A1',-1);
		% lmiterm([ 3 2 1  E2],1,1);
		% lmiterm([ 3 2 1 -E1],-1,A1);	
		% lmiterm([ 3 2 2  E1],1,1,'s');

		% lmiterm([ 4 1 1  V1],A2',1,'s');
		% lmiterm([ 4 1 1  E2],A1',-1,'s');
		% lmiterm([ 4 1 2 -E2],1,1);
		% lmiterm([ 4 1 2  E1],A1',-1);
		% lmiterm([ 4 2 1  E2],1,1);
		% lmiterm([ 4 2 1 -E1],-1,A1);	
		% lmiterm([ 4 2 2  E1],1,1,'s');


		% lmiterm([ 5 1 1  V2],A1',1,'s');
		% lmiterm([ 5 1 1  E2],A2',-1,'s');
		% lmiterm([ 5 1 2 -E2],1,1);
		% lmiterm([ 5 1 2  E1],A2',-1);
		% lmiterm([ 5 2 1  E2],1,1);
		% lmiterm([ 5 2 1 -E1],-1,A2);	
		% lmiterm([ 5 2 2  E1],1,1,'s');		


		% lmiterm([ 6 1 1  V2],A2',1,'s');
		% lmiterm([ 6 1 1  E2],A2',-1,'s');
		% lmiterm([ 6 1 2 -E2],1,1);
		% lmiterm([ 6 1 2  E1],A2',-1);
		% lmiterm([ 6 2 1  E2],1,1);
		% lmiterm([ 6 2 1 -E1],-1,A2);	
		% lmiterm([ 6 2 2  E1],1,1,'s');	
		
		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys,options,target);
		
		% if tmin<0
			% param6 = [param6 [alpha beta]'];
			% count6 = count6 + 1;
			% hold on;
		% end

		% end
	% end


	% [m n] = size(param6);
	% param6 = param6(:,2:n);
	% timestr = datestr(now,30);
	% fid = fopen([timestr,'_param6.txt'],'w');			
	% fprintf(fid,'%6.2f\t %6.2f\n',param6);
	% fclose(fid);
	% plot(param6(1,:),param6(2,:),'s','markersize',6);
	% hold on;


	
	% for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		% for alpha =  -70:step:20		% for alpha =  -2:0.05:1

		% if(rate*alpha-beta>gamma)
			% continue;
		% end
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
		
		% setlmis([]);
		
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		% E1=lmivar(3,5+[1 2;3 4]);
		% E2=lmivar(3,9+[1 2;3 4]);
		% [x,n,W]=lmivar(1,[4 1]);
		% cw = mat2cell(W,[2 2],[2 2]);
		% CW11 = lmivar(3,cw{1,1});
		% CW12 = lmivar(3,cw{1,2});
		% CW21 = lmivar(3,cw{2,1});
		% CW22 = lmivar(3,cw{2,2});
				
		% lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 

		% lmiterm([ 3 1 1 E1],1,1,'s');
		
		% lmiterm([-4 1 1  CW11],1,1);
		% lmiterm([-4 1 2  CW12],1,1);
		% lmiterm([-4 2 1  CW21],1,1);
		% lmiterm([-4 2 2  CW22],1,1);

		% lmiterm([ 5 1 1  V1],A1',1,'s');
		% lmiterm([ 5 1 1  E2],A1',-1,'s');
		% lmiterm([ 5 1 2 -E2],1,1);
		% lmiterm([ 5 1 2  E1],A1',-1);
		% lmiterm([ 5 2 1  E2],1,1);
		% lmiterm([ 5 2 1 -E1],-1,A1);	
		% lmiterm([ 5 2 2  E1],1,1,'s');
		% lmiterm([ 5 1 1 CW11],1,1);
		% lmiterm([ 5 1 2 CW12],1,1);
		% lmiterm([ 5 2 1 CW21],1,1);
		% lmiterm([ 5 2 2 CW22],1,1);

		% lmiterm([ 6 1 1  V1],A2',1,'s');
		% lmiterm([ 6 1 1  E2],A1',-1,'s');
		% lmiterm([ 6 1 2 -E2],1,1);
		% lmiterm([ 6 1 2  E1],A1',-1);
		% lmiterm([ 6 2 1  E2],1,1);
		% lmiterm([ 6 2 1 -E1],-1,A1);	
		% lmiterm([ 6 2 2  E1],1,1,'s');
		% lmiterm([ 6 1 1 CW11],-1,1);
		% lmiterm([ 6 1 2 CW12],-1,1);
		% lmiterm([ 6 2 1 CW21],-1,1);
		% lmiterm([ 6 2 2 CW22],-1,1);


		% lmiterm([ 7 1 1  V2],A1',1,'s');
		% lmiterm([ 7 1 1  E2],A2',-1,'s');
		% lmiterm([ 7 1 2 -E2],1,1);
		% lmiterm([ 7 1 2  E1],A2',-1);
		% lmiterm([ 7 2 1  E2],1,1);
		% lmiterm([ 7 2 1 -E1],-1,A2);	
		% lmiterm([ 7 2 2  E1],1,1,'s');		
		% lmiterm([ 7 1 1 CW11],-1,1);
		% lmiterm([ 7 1 2 CW12],-1,1);
		% lmiterm([ 7 2 1 CW21],-1,1);
		% lmiterm([ 7 2 2 CW22],-1,1);

		% lmiterm([ 8 1 1  V2],A2',1,'s');
		% lmiterm([ 8 1 1  E2],A2',-1,'s');
		% lmiterm([ 8 1 2 -E2],1,1);
		% lmiterm([ 8 1 2  E1],A2',-1);
		% lmiterm([ 8 2 1  E2],1,1);
		% lmiterm([ 8 2 1 -E1],-1,A2);	
		% lmiterm([ 8 2 2  E1],1,1,'s');	
		% lmiterm([ 8 1 1 CW11],1,1);
		% lmiterm([ 8 1 2 CW12],1,1);
		% lmiterm([ 8 2 1 CW21],1,1);
		% lmiterm([ 8 2 2 CW22],1,1);
		
		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys,options,target);
		
		% if tmin<0
			% param7 = [param7 [alpha beta]'];
			% count7 = count7 + 1;
			% hold on;
		% end

		% end
	% end


	% [m n] = size(param7);
	% param7 = param7(:,2:n);
	% timestr = datestr(now,30);
	% fid = fopen([timestr,'_param7.txt'],'w');			
	% fprintf(fid,'%6.2f\t %6.2f\n',param7);
	% fclose(fid);
	% plot(param7(1,:),param7(2,:),'s','markersize',6);
	% hold on;
	


	for beta = -30:step:10				% for beta = -0.6:0.05:0.2
		for alpha =  -70:step:20		% for alpha =  -2:0.05:1

		if(rate*alpha-beta>gamma)
			continue;
		end
		
		A1=[-2 alpha;19 beta];
		A2=[-4 alpha;-1 beta];
		
		setlmis([]);
		
		V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		E1=lmivar(3,5+[1 2;2 3]);
		E2=lmivar(3,8+[1 2;3 4]);
		 W=lmivar(1,[2 1]);				% W

		
		lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 

		lmiterm([ 3 1 1 E1],1,1);
		lmiterm([-4 1 1  W],1,1);
		
		lmiterm([ 5 1 1 -V1],4,A1,'s');
		lmiterm([ 5 1 1  E1],-A1',A1,'s');
		lmiterm([ 5 1 1 -E2],-2,A1,'s');
		lmiterm([ 5 1 1  W],1,1);
		lmiterm([ 5 1 2 -E2],1,1);
		lmiterm([ 5 2 1  E2],1,1);
		lmiterm([ 5 2 2  E1],1,1/2);

		lmiterm([ 6 1 1 -V2],4,A2,'s');
		lmiterm([ 6 1 1  E1],-A2',A2,'s');
		lmiterm([ 6 1 1 -E2],-2,A2,'s');
		lmiterm([ 6 1 1   W],1,1);
		lmiterm([ 6 1 2 -E2],1,1);
		lmiterm([ 6 2 1  E2],1,1);
		lmiterm([ 6 2 2  E1],1,1/2);

		lmiterm([ 7 1 1 -V1],4,A2,'s');
		lmiterm([ 7 1 1  E1],-A1',A2,'s');
		lmiterm([ 7 1 1 -E2],-2,A1,'s');
		lmiterm([ 7 1 1   W],-1,1);
		lmiterm([ 7 1 2 -E2],1,1);
		lmiterm([ 7 2 1  E2],1,1);
		lmiterm([ 7 2 2  E1],1,1/2);

		lmiterm([ 8 1 1 -V2],4,A2,'s');
		lmiterm([ 8 1 1  E1],-A2',A1,'s');
		lmiterm([ 8 1 1 -E2],-2,A2,'s');
		lmiterm([ 8 1 1   W],-1,1);
		lmiterm([ 8 1 2 -E2],1,1);
		lmiterm([ 8 2 1  E2],1,1);
		lmiterm([ 8 2 2  E1],1,1/2);
		
		lmisys=getlmis;
		[tmin,xfeas]=feasp(lmisys,options,target);
		
		if tmin<0
			param8 = [param8 [alpha beta]'];
			count8 = count8 + 1;
			hold on;
		end

		end
	end



	[m n] = size(param8);
	param8 = param8(:,2:n);
	timestr = datestr(now,30);
	fid = fopen([timestr,'_param8.txt'],'w');			
	fprintf(fid,'%6.2f\t %6.2f\n',param8);
	fclose(fid);
	plot(param8(1,:),param8(2,:),'s','markersize',6);
	hold on;

	
		
		
	% for beta = -30:1:10
		% for alpha =  -70:1:20
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
		
		% setlmis([]);
		
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		
		% lamda12 = lmivar(3,[6 7;8 9]);

		% lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2 

		% lmiterm([ 3 1 1 V1],A2',1,'s');
		% lmiterm([ 3 1 1 V2],A1',1,'s');
		% lmiterm([-3 1 1 lamda12],1,1,'s');

		
		% lmiterm([4 1 1 V1],A1',1,'s');
		% lmiterm([4 1 2  lamda12],1,1);
		% lmiterm([4 2 1 -lamda12],1,1);
		% lmiterm([4 2 2 V2],A2',1,'s');
		
		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys);
		
		% if tmin<0
			% count0 = count0 + 1;
			% plot(alpha,beta,'o','markersize',5);
			% hold on;
		% end

		% end
	% end

	


	
	
	
	
	


	% for beta = -30:1:10
		% for alpha =  -70:1:20
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
			
		% setlmis([]);
			
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
		% E2=lmivar(3,[6 7;8 9]);			% E2				
		% E1=lmivar(3,[10 11;12 13]);		% E1
		
		% lmiterm([-1 1 1 V1],1/2,1,'s');	% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1/2,1,'s');	% 0<V2:V2 
				
		% lmiterm([3 1 1 -V1], 1,A1,'s');	% (V1'*A1+A1'*V1)/2
		% lmiterm([3 1 1 -E2],-1,A1,'s');	% (-E2'*A1-A1'*E2)/2
		% lmiterm([3 1 2 -E2],1,1);			% E2'/2
		% lmiterm([3 1 2  E1],A1',-1);		% -A1'E1/2	
		% lmiterm([3 2 1  E2],1,1);			% E2/2
		% lmiterm([3 2 1 -E1],-1,A1);		% -E1'A1/2
		% lmiterm([3 2 2  E1],1,1,'s');		% (E1+E1')/2
		
		% lmiterm([4 1 1 -V1], 1,A2,'s');	% (V1'*A2+A2'*V1)/2
		% lmiterm([4 1 1 -E2],-1,A1,'s');	% (-E2'*A1-A1'*E2)/2
		% lmiterm([4 1 2 -E2],1,1);			% E2'/2
		% lmiterm([4 1 2  E1],A1',-1);		% -A1'E1/2	
		% lmiterm([4 2 1  E2],1,1);			% E2/2
		% lmiterm([4 2 1 -E1],-1,A1);		% -E1'A1/2
		% lmiterm([4 2 2  E1],1,1,'s');		% (E1+E1)/2
		
		% lmiterm([5 1 1 -V2], 1,A1,'s');	% (V2'*A1+A1'*V2)/2
		% lmiterm([5 1 1 -E2],-1,A2,'s');	% (-E2'*A2-A2'*E2)/2
		% lmiterm([5 1 2 -E2],1,1);			% E2'/2
		% lmiterm([5 1 2  E1],A2',-1);		% -A2'E1/2	
		% lmiterm([5 2 1  E2],1,1);			% E2/2
		% lmiterm([5 2 1 -E1],-1,A2);		% -E1'A2/2
		% lmiterm([5 2 2  E1],1,1,'s');		% (E1+E1)/2

		
		% lmiterm([6 1 1 -V2], 1,A2,'s');	% (V2'*A2+A2'*V2)/2
		% lmiterm([6 1 1 -E2],-1,A2,'s');	% (-E2'*A2-A2'*E2)/2
		% lmiterm([6 1 2 -E2],1,1);			% E2'/2
		% lmiterm([6 1 2  E1],A2',-1);		% -A2'E1/2	
		% lmiterm([6 2 1  E2],1,1);			% E2/2
		% lmiterm([6 2 1 -E1],-1,A2);		% -E1'A2/2
		% lmiterm([6 2 2  E1],1,1,'s');		% (E1+E1)/2

		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys);
		
		% if tmin<0
			% count2 = count2 + 1;
			% plot(alpha,beta,'-rs','markersize',5);
			% hold on;
		% end

		% end
	% end


	% for beta = -30:1:0  				%[-30 0]
		% for alpha =  -70:1:10 		%[-70 10]

			% A1=[-2 alpha;19 beta];
			% A2=[-4 alpha;-1 beta];

			% setlmis([]);

			% P  = lmivar(3,[1 2;3 4]);
			% E1 = lmivar(3,[5 6;7 8]);
			% E2 = lmivar(3,[9 10;11 12]);

			
			% lmiterm([-1 1 1 P],1/2,1,'s');

			% lmiterm([2 1 1   P],1,A1,'s');
			% lmiterm([2 1 1  E2],A1',-1,'s');
			% lmiterm([2 1 2 -E2],1,1);
			% lmiterm([2 1 2  E1],A1',-1);
			% lmiterm([2 2 1  E2],1,1);
			% lmiterm([2 2 1 -E1],-1,A1);
			% lmiterm([2 2 2  E1],1,1,'s');


			% lmiterm([3 1 1   P],1,A2,'s');
			% lmiterm([3 1 1  E2],A2',-1,'s');
			% lmiterm([3 1 2 -E2],1,1);
			% lmiterm([3 1 2  E1],A2',-1);
			% lmiterm([3 2 1  E2],1,1);
			% lmiterm([3 2 1 -E1],-1,A2);
			% lmiterm([3 2 2  E1],1,1,'s');
			
	
			% lmisys=getlmis;
			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% count3 = count3 + 1;
				% plot(alpha,beta,'.','markersize',6);
				% hold on;
			% end
		% end
	% end
	
	cnt = [count0 count1 count2 count3 count4 count5 count6 count7 count8];
end

