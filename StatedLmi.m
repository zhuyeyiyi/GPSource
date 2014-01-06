function [P0]=StatedLmi()

	clc;
	close all;
	clear all;
	cnt0 = 0;
	cnt1 = 0;
	cnt2 = 0;
	
	% for beta = -30:1:0
		% for alpha =  -100:1:10

			% A1=[-2 alpha;19 beta];
			% A2=[-4 alpha;-1 beta];
				
			% setlmis([]);
			
			% TNegA1 = (-1)*A1';
			% TNegA2 = (-1)*A2';

			% setlmis([])

			% P1=lmivar(3,[1 2;2 3]);
			% P2=lmivar(3,[4 2;2 3]);
			% W=lmivar(1,[2 1]);

			% lmiterm([-1 1 1 P1],1,1);		% 0<P1:P1
			% lmiterm([-2 1 1 P2],1,1);		% 0<P2:P2 
			% lmiterm([-3 1 1 W],1,1);		% 0<W:W

			% lmiterm([4 1 1 P1],1,A1,'s');	% P1*A1+A1'*P1'+W<0:P1*A1+A1*P1'
			% lmiterm([4 1 1 W],1,1);			% P1*A1+A1*P1'+W<0:W

			% lmiterm([5 1 1 P2],1,A2,'s');	% P2*A2+A2'*P2'+W<0:P2*A2+A2*P2'
			% lmiterm([5 1 1 W],1,1);			% P2*A2+A2*P2'+W<0:W

			% lmiterm([6 1 1 P1],1,A2,'s');	% P1*A2+A2'*P1'-W<0:P1*A2+A2'*P2'
			% lmiterm([6 1 1 W],-1,1);		% P1*A2+A2'*P1'-W<0:-W

			% lmiterm([7 1 1 P2],1,A1,'s');	% P2*A1+A1'*P2'-W<0:P2*A1+A1'*P2'
			% lmiterm([7 1 1 W],-1,1);		% P2*A1+A1'*P2'-W<0:-W


			% lmisys=getlmis;

			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% cnt1 = cnt1 + 1;
				% plot(alpha,beta,'o','markersize',10);
				% hold on;
			% end;
		% end;	
	% end;


	% for beta = -30:1:0
		% for alpha =  -100:1:10

			% A1=[-2 alpha;19 beta];
			% A2=[-4 alpha;-1 beta];

			% setlmis([])

			% P=lmivar(1,[2 1]);
			
			% lmiterm([-1 1 1 P],1,1);

			% lmiterm([2 1 1 P],1,A1,'s');
			% lmiterm([3 1 1 P],1,A2,'s');

			% lmisys=getlmis;
			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% cnt2 = cnt2 + 1;
				% plot(alpha,beta,'.','markersize',11);
				% hold on;
			% end;
		% end;
	% end;

	% for a=1:1:100
		% for b=5:1:20	%a=25;b=20;

		% A1=[-1002.5/a 1000/a;0.5/b -200/b];
		% A2=[-2.5/a 1000/a;0.5/b -200/b];
		% setlmis([]);
			
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
			% cnt0 = cnt0 + 1;
			% plot(a,b,'o','markersize',11);
			% hold on;
		% end
		% end
	% end

		
	% for a=1:1:100
		% for b=5:1:20	%a=25;b=20;

			% A1=[-1002.5/a 1000/a;0.5/b -200/b];
			% A2=[-2.5/a 1000/a;0.5/b -200/b];
			% setlmis([]);

			% P1=lmivar(3,[1 2;2 3]);
			% P2=lmivar(3,[4 2;2 3]);
			% W=lmivar(1,[2 1]);

			% lmiterm([-1 1 1 P1],1,1);		% 0<P1:P1
			% lmiterm([-2 1 1 P2],1,1);		% 0<P2:P2 
			% lmiterm([-3 1 1 W],1,1);		% 0<W:W

			% lmiterm([4 1 1 P1],1,A1,'s');	% P1*A1+A1'*P1'+W<0:P1*A1+A1*P1'
			% lmiterm([4 1 1 W],1,1);			% P1*A1+A1*P1'+W<0:W

			% lmiterm([5 1 1 P2],1,A2,'s');	% P2*A2+A2'*P2'+W<0:P2*A2+A2*P2'
			% lmiterm([5 1 1 W],1,1);			% P2*A2+A2*P2'+W<0:W

			% lmiterm([6 1 1 P1],1,A2,'s');	% P1*A2+A2'*P1'-W<0:P1*A2+A2'*P2'
			% lmiterm([6 1 1 W],-1,1);		% P1*A2+A2'*P1'-W<0:-W

			% lmiterm([7 1 1 P2],1,A1,'s');	% P2*A1+A1'*P2'-W<0:P2*A1+A1'*P2'
			% lmiterm([7 1 1 W],-1,1);		% P2*A1+A1'*P2'-W<0:-W


			% lmisys=getlmis;

			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% cnt1 = cnt1 + 1;
				% plot(a,b,'rs','markersize',10);
				% hold on;
			% end;
		% end;	
	% end;

	% for a=1:1:100
		% for b=5:1:20 	%a=25;b=20;

			% A1=[-1002.5/a 1000/a;0.5/b -200/b];
			% A2=[-2.5/a 1000/a;0.5/b -200/b];

			% setlmis([])

			% P=lmivar(1,[2 1]);
			
			% lmiterm([-1 1 1 P],1,1);

			% lmiterm([2 1 1 P],1,A1,'s');
			% lmiterm([3 1 1 P],1,A2,'s');

			% lmisys=getlmis;
			% [tmin,xfeas]=feasp(lmisys);

			% if tmin<0
				% cnt2 = cnt2 + 1;
				% plot(a,b,'.','markersize',11);
				% hold on;
			% end;
		% end;
	% end;
	
	A1 = [-1 2;1 -3];
	A2 = [-0.8 1.5;1.3 -2.7];
	A3 = [-1.4 0.9;0.7 -2.0];
	
	A1_T = A1';
	A2_T = A2';
	A3_T = A3';
	
	setlmis([]);

	P = lmivar(3,[1 2;3 4]);
	P_t = lmivar(3,[1 3;2 4]);

	lmiterm([-1 1 1 P],1,1);
	
	lmiterm([2 1 1 P],1,A1,'s');
	%lmiterm([1 1 1 P_t],A1_T,1);

	lmiterm([3 1 1 P],1,A2,'s');
	%lmiterm([2 1 1 P_t],A2_T,1);
	
	lmiterm([4 1 1 P],1,A3,'s');
	%lmiterm([3 1 1 P_t],A3_T,1);


	%lmiterm([4 1 1 0],1);

	
	lmis = getlmis;
	
	[tmin,xfeas] = feasp(lmis);

	P0 = dec2mat(lmis,xfeas,P);
	
end

