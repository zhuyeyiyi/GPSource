function [count0 count1 count2 count3 count4]=StatedExample0() 
	
	clc;
	close all;
	clear all;
	count0 = 0;
	count1 = 0;
	count2 = 0;
	count3 = 0;
	count4 = 0;
	
	for beta = -30:1:0
		for alpha =  -70:1:10
		
		A1=[-2 alpha;19 beta];
		A2=[-4 alpha;-1 beta];
			
		TNegA1 = (-1)*A1';
		TNegA2 = (-1)*A2';

		setlmis([]);
			
		V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		V2=lmivar(3,[5 6;7 8]);			% V2=[X4 X2;X2 X3]
		E2=lmivar(3,[9 10;11 12]);			% E2
		E1=lmivar(1,[2 1]);				% E1
		 W=lmivar(1,[2 1]);				% W
		
		lmiterm([-1 1 1 V1],1,1);		% 0<V1:V1
	
		lmiterm([-2 1 1 V2],1,1);		% 0<V2:V2 
		
		lmiterm([3 1 1 E1],1,1);		% E1<0:E1
		
		lmiterm([-4 1 1 W],1,1);		% 0<W:W
		
		lmiterm([5 1 1 V1],4,A1,'s');		% 4*V1*A1+4*A1'*V1
		lmiterm([5 1 1 E1],TNegA1,A1,'s');	% -A1'*E1*A1-A1'*E1*A1
		lmiterm([5 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
		lmiterm([5 1 1  W],1,1);			% W
		lmiterm([5 1 2 -E2],1,1);			% E2'
		lmiterm([5 2 1 E2],1,1);			% E2
		lmiterm([5 2 2 E1],0.5,1);			% E1
		
		lmiterm([6 1 1 V1],4,A2,'s');		% 4*V1*A2+4*A2'*V1
		lmiterm([6 1 1 E1],TNegA1,A2,'s');	% -A1'*E1*A2-A2'*E1*A1
		lmiterm([6 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
		lmiterm([6 1 1  W],-1,1);			% -W
		lmiterm([6 1 2 -E2],1,1);			% E2'
		lmiterm([6 2 1 E2],1,1);			% E2
		lmiterm([6 2 2 E1],0.5,1);			% E1
		
		lmiterm([7 1 1 V2],4,A1,'s');		% 4*V2*A1+4*A1'*V2
		lmiterm([7 1 1 E1],TNegA2,A1,'s');	% -A2'*E1*A1-A1'*E1*A2
		lmiterm([7 1 1 E2],TNegA2,2,'s');	% -E2'*A2-A2'*E2
		lmiterm([7 1 1  W],-1,1);			% -W
		lmiterm([7 1 2 -E2],1,1);			% E2'
		lmiterm([7 2 1 E2],1,1);			% E2
		lmiterm([7 2 2 E1],0.5,1);			% E1
		
		lmiterm([8 1 1 V2],4,A2,'s');		% 4*V2*A2+4*A2'*V2
		lmiterm([8 1 1 E1],TNegA2,A2,'s');	% -A2'*E1*A2-A2'*E1*A2
		lmiterm([8 1 1 E2],TNegA2,2,'s');	% -2E2'*A2-2A2'*E2
		lmiterm([8 1 1  W],1,1);			% W
		lmiterm([8 1 2 -E2],1,1);			% E2'
		lmiterm([8 2 1 E2],1,1);			% E2
		lmiterm([8 2 2 E1],0.5,1);			% E1

		lmisys=getlmis;
		[tmin,xfeas]=feasp(lmisys);
		
		if tmin<0
			count0 = count0 + 1;
			plot(alpha,beta,'-rs','markersize',5);
			hold on;
		end

		end
	end
	
	% for beta = -30:1:0
		% for alpha =  -70:1:10
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
			
		% TNegA1 = (-1)*A1';
		% TNegA2 = (-1)*A2';

		% setlmis([]);
			
		% V1=lmivar(3,[1 2;2 3]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[4 2;2 3]);			% V2=[X4 X2;X2 X3]
		% E2=lmivar(3,[5 6;7 8]);			% E2
		% E1=lmivar(1,[2 1]);				% E1
		
		
		% lmiterm([-1 1 1 V1],1,1);		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1,1);		% 0<V2:V2 
		
		% lmiterm([3 1 1 E1],1,1);		% E1<0:E1
		
		% lmiterm([4 1 1 V1],4,A1,'s');		% 4*V1*A1+4*A1'*V1
		% lmiterm([4 1 1 E1],TNegA1,A1,'s');	% -A1'*E1*A1
		% lmiterm([4 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
		% lmiterm([4 1 2 -E2],1,1);			% E2'
		% lmiterm([4 2 1 E2],1,1);			% E2
		% lmiterm([4 2 2 E1],0.5,1);			% E1
		
		% lmiterm([5 1 1 V1],4,A2,'s');		% 4*V1*A2+4*A2'*V1
		% lmiterm([5 1 1 E1],TNegA1,A2,'s');	% -A1'*E1*A2
		% lmiterm([5 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
		% lmiterm([5 1 2 -E2],1,1);			% E2'
		% lmiterm([5 2 1 E2],1,1);			% E2
		% lmiterm([5 2 2 E1],0.5,1);			% E1
		
		% lmiterm([6 1 1 V2],4,A1,'s');		% 4*V2*A1+4*A1'*V2
		% lmiterm([6 1 1 E1],TNegA2,A1,'s');	% -A2'*E1*A1
		% lmiterm([6 1 1 E2],TNegA2,2,'s');	% -E2'*A2-A2'*E2
		% lmiterm([6 1 2 -E2],1,1);			% E2'
		% lmiterm([6 2 1 E2],1,1);			% E2
		% lmiterm([6 2 2 E1],0.5,1);			% E1
		
		% lmiterm([7 1 1 V2],4,A2,'s');		% 4*V2*A2+4*A2'*V2
		% lmiterm([7 1 1 E1],TNegA2,A2,'s');	% -A2'*E1*A2
		% lmiterm([7 1 1 E2],TNegA2,2,'s');	% -2E2'*A2-2A2'*E2
		% lmiterm([7 1 2 -E2],1,1);			% E2'
		% lmiterm([7 2 1 E2],1,1);			% E2
		% lmiterm([7 2 2 E1],0.5,1);			% E1
			
		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys);

		% if tmin<0
			% count1 = count1 + 1;
			% plot(alpha,beta,'o','markersize',7);
			% hold on;
		% end
			
		
		% end
	% end
	
	% for beta = -30:1:0
		% for alpha =  -70:1:10
		
			% A1=[-2 alpha;19 beta];
			% A2=[-4 alpha;-1 beta];
			
			% setlmis([]);
			
			% V1=lmivar(3,[1 2;2 3]);			% V1=[X1 X2;X2 X3]
			% V2=lmivar(3,[4 5;5 6]);			% V2=[X4 X2;X2 X3]
			% W=lmivar(1,[2 1]);				% W

			% lmiterm([-1 1 1 V1],1,1);		% 0<V1:V1
			
			% lmiterm([-2 1 1 V2],1,1);		% 0<V2:V2 
			
			% lmiterm([-3 1 1 W],1,1);		% 0<W:W

			% lmiterm([4 1 1 V1],1,A1,'s');	% V1*A1+A1'*V1'+W<0:V1*A1+A1*V1'
			% lmiterm([4 1 1 W],1,1);			% V1*A1+A1*V1'+W<0:W

			% lmiterm([5 1 1 V2],1,A2,'s');	% V2*A2+A2'*V2'+W<0:V2*A2+A2*V2'
			% lmiterm([5 1 1 W],1,1);			% V2*A2+A2*V2'+W<0:W

			% lmiterm([6 1 1 V1],1,A2,'s');	% V1*A2+A2'*V1'-W<0:V1*A2+A2'*V2'
			% lmiterm([6 1 1 W],-1,1);		% V1*A2+A2'*V1'-W<0:-W

			% lmiterm([7 1 1 V2],1,A1,'s');	% V2*A1+A1'*V2'-W<0:V2*A1+A1'*V2'
			% lmiterm([7 1 1 W],-1,1);		% V2*A1+A1'*V2'-W<0:-W
			
			% lmisys=getlmis;
			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% count2 = count2 + 1;
				% plot(alpha,beta,'o','markersize',10);
				% hold on;
			% end
			
		% end
	% end
	
	% for beta = -30:1:0
		% for alpha =  -70:1:10
		
		% A1=[-2 alpha;19 beta];
		% A2=[-4 alpha;-1 beta];
			
		% TNegA1 = (-1)*A1';
		% TNegA2 = (-1)*A2';

		% setlmis([]);
			
		% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
		% V2=lmivar(3,[5 6;7 8]);			% V2=[X4 X2;X2 X3]
		% E2=lmivar(3,[9 10;11 12]);		% E2
		% E1=lmivar(1,[2 1]);				% E1
		 % W=lmivar(1,[2 1]);				% W
		
		% lmiterm([-1 1 1 V1],1,1);		% 0<V1:V1
	
		% lmiterm([-2 1 1 V2],1,1);		% 0<V2:V2 
		
		% lmiterm([3 1 1 E1],1,1);		% E1<0:E1
		
		% lmiterm([-4 1 1 W],1,1);		% 0<W:W
		
		% lmiterm([5 1 1 V1],4,A1,'s');		% 4*V1*A1+4*A1'*V1
		% lmiterm([5 1 1 E1],TNegA1,A1,'s');	% -A1'*E1*A1-A1'*E1*A1
		% lmiterm([5 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
		% lmiterm([5 1 1  W],1,1);			% W
		% lmiterm([5 1 2 -E2],1,1);			% E2'
		% lmiterm([5 2 1 E2],1,1);			% E2
		% lmiterm([5 2 2 E1],0.5,1);			% E1
		
		% lmiterm([6 1 1 V1],4,A2,'s');		% 4*V1*A2+4*A2'*V1
		% lmiterm([6 1 1 E1],TNegA1,A2,'s');	% -A1'*E1*A2-A2'*E1*A1
		% lmiterm([6 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
		% lmiterm([6 1 1  W],-1,1);			% -W
		% lmiterm([6 1 2 -E2],1,1);			% E2'
		% lmiterm([6 2 1 E2],1,1);			% E2
		% lmiterm([6 2 2 E1],0.5,1);			% E1
		
		% lmiterm([7 1 1 V2],4,A1,'s');		% 4*V2*A1+4*A1'*V2
		% lmiterm([7 1 1 E1],TNegA2,A1,'s');	% -A2'*E1*A1-A1'*E1*A2
		% lmiterm([7 1 1 E2],TNegA2,2,'s');	% -E2'*A2-A2'*E2
		% lmiterm([7 1 1  W],-1,1);			% -W
		% lmiterm([7 1 2 -E2],1,1);			% E2'
		% lmiterm([7 2 1 E2],1,1);			% E2
		% lmiterm([7 2 2 E1],0.5,1);			% E1
		
		% lmiterm([8 1 1 V2],4,A2,'s');		% 4*V2*A2+4*A2'*V2
		% lmiterm([8 1 1 E1],TNegA2,A2,'s');	% -A2'*E1*A2-A2'*E1*A2
		% lmiterm([8 1 1 E2],TNegA2,2,'s');	% -2E2'*A2-2A2'*E2
		% lmiterm([8 1 1  W],1,1);			% W
		% lmiterm([8 1 2 -E2],1,1);			% E2'
		% lmiterm([8 2 1 E2],1,1);			% E2
		% lmiterm([8 2 2 E1],0.5,1);			% E1

		% lmisys=getlmis;
		% [tmin,xfeas]=feasp(lmisys);
		
		% if tmin<0
			% count0 = count0 + 1;
			% plot(alpha,beta,'-rs','markersize',8);
			% hold on;
		% end

		% end
	% end

	
	% for beta = -30:1:0
		% for alpha =  -70:1:10
		
			% A1=[-2 alpha;19 beta];
			% A2=[-4 alpha;-1 beta];
			
			% setlmis([]);
			
			% V1=lmivar(3,[1 2;3 4]);			% V1=[X1 X2;X2 X3]
			% V2=lmivar(3,[5 2;3 4]);			% V2=[X4 X2;X2 X3]
			% W=lmivar(1,[2 1]);				% W

			% lmiterm([-1 1 1 V1],1,1);		% 0<V1:V1
			
			% lmiterm([-2 1 1 V2],1,1);		% 0<V2:V2 
			
			% lmiterm([-3 1 1 W],1,1);		% 0<W:W

			% lmiterm([4 1 1 V1],1,A1,'s');	% V1*A1+A1'*V1'+W<0:V1*A1+A1*V1'
			% lmiterm([4 1 1 W],1,1);			% V1*A1+A1*V1'+W<0:W

			% lmiterm([5 1 1 V2],1,A2,'s');	% V2*A2+A2'*V2'+W<0:V2*A2+A2*V2'
			% lmiterm([5 1 1 W],1,1);			% V2*A2+A2*V2'+W<0:W

			% lmiterm([6 1 1 V1],1,A2,'s');	% V1*A2+A2'*V1'-W<0:V1*A2+A2'*V2'
			% lmiterm([6 1 1 W],-1,1);		% V1*A2+A2'*V1'-W<0:-W

			% lmiterm([7 1 1 V2],1,A1,'s');	% V2*A1+A1'*V2'-W<0:V2*A1+A1'*V2'
			% lmiterm([7 1 1 W],-1,1);		% V2*A1+A1'*V2'-W<0:-W
			
			% lmisys=getlmis;
			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% count2 = count2 + 1;
				% plot(alpha,beta,'-rs','markersize',8);
				% hold on;
			% end
			
		% end
	% end

	
	
	% for beta = -30:1:0
		% for alpha =  -70:1:10
		
			% A1=[-2 alpha;19 beta];
			% A2=[-4 alpha;-1 beta];

			% setlmis([]);

			% P1=lmivar(3,[1 2;3 4]);
			% P2=lmivar(3,[5 6;7 8]);

			% lmiterm([-1 1 1 P1],1,1);
			% lmiterm([-2 1 1 P2],1,1);


			% lmiterm([3 1 1 P1],1,A1,'s');
			
			
			% lmiterm([4 1 1 P1],1,A2,'s');
			
			% lmiterm([5 1 1 P2],1,A1,'s');

			
			% lmiterm([6 1 1 P2],1,A2,'s');

			
			% lmisys=getlmis;
			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% SP1 = dec2mat(lmisys,xfeas,P1);
				% SP2 = dec2mat(lmisys,xfeas,P2);
				% count3 = count3 + 1;
				% plot(alpha,beta,'o','markersize',10);
				% hold on;
			% end
		% end
	% end



	for beta = -30:1:0
		for alpha =  -70:1:10
		
			A1=[-2 alpha;19 beta];
			A2=[-4 alpha;-1 beta];

			setlmis([]);

			P=lmivar(3,[1 2; 3 4]);

			lmiterm([-1 1 1 P],1/2,1,'s');

			lmiterm([2 1 1 P],1,A1,'s');
			lmiterm([3 1 1 P],1,A2,'s');

			lmisys=getlmis;
			[tmin,xfeas]=feasp(lmisys);

			if tmin<0
				count4 = count4 + 1;
				plot(alpha,beta,'.','markersize',8);
				hold on;
			end
		end
	end

	for beta = -30:1:0
		for alpha =  -70:1:10
		
			A1=[-2 alpha;19 beta];
			A2=[-4 alpha;-1 beta];

			setlmis([]);

			P=lmivar(3,[1 2; 3 4]);

			lmiterm([-1 1 1 P],1,1);

			lmiterm([2 1 1 P],1,A1,'s');
			lmiterm([3 1 1 P],1,A2,'s');

			lmisys=getlmis;
			[tmin,xfeas]=feasp(lmisys);

			if tmin<0
				count4 = count4 + 1;
				plot(alpha,beta,'.','markersize',8);
				hold on;
			end
		end
	end
end