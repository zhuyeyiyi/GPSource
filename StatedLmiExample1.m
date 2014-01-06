function [count1 count2]=StatedLmiExample1() 

	clc;
	close all;
	clear all;
	count1 = 0;
	count2 = 0;
	
	for squarex = 0.1:1:50
			
			theta1 = 2500/squarex;
			theta2 = 2000/squarex;
			theta3 = 2500/(100-squarex);
			theta4 = 2000/(100-squarex);
			
			A1=[-1002.5/theta1 1000/theta1;0.5/theta2 -200/theta2];
			A2=[-2.5/theta3 1000/theta3;0.5/theta4 -200/theta4];
			
			TNegA1 = (-1)*A1';
			TNegA2 = (-1)*A2';
			

			setlmis([]);

			V1=lmivar(3,[1 2;2 3]);			% V1=[X1 X2;X2 X3]
			V2=lmivar(3,[4 2;2 3]);			% V2=[X4 X2;X2 X3]
			E2=lmivar(3,[5 6;7 8]);			% E2
			E1=lmivar(1,[2 1]);				% E1
			
			lmiterm([-1 1 1 V1],1,1);		% 0<V1:V1
		
			lmiterm([-2 1 1 V2],1,1);		% 0<V2:V2 
			
			lmiterm([3 1 1 E1],1,1);		% E1<0:E1
			
			lmiterm([4 1 1 V1],4,A1,'s');		% 4*V1*A1+4*A1'*V1
			lmiterm([4 1 1 E1],TNegA1,A1,'s');	% -A1'*E1*A1
			lmiterm([4 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
			lmiterm([4 1 2 -E2],1,1);			% E2'
			lmiterm([4 2 1 E2],1,1);			% E2
			lmiterm([4 2 2 E1],0.5,1);			% E1
			
			lmiterm([5 1 1 V1],4,A2,'s');		% 4*V1*A2+4*A2'*V1
			lmiterm([5 1 1 E1],TNegA1,A2,'s');	% -A1'*E1*A2
			lmiterm([5 1 1 E2],TNegA1,2,'s');	% -2E2'*A1-2A1'*E2
			lmiterm([5 1 2 -E2],1,1);			% E2'
			lmiterm([5 2 1 E2],1,1);			% E2
			lmiterm([5 2 2 E1],0.5,1);			% E1
			
			lmiterm([6 1 1 V2],4,A1,'s');		% 4*V2*A1+4*A1'*V2
			lmiterm([6 1 1 E1],TNegA2,A1,'s');	% -A2'*E1*A1
			lmiterm([6 1 1 E2],TNegA2,2,'s');	% -E2'*A2-A2'*E2
			lmiterm([6 1 2 -E2],1,1);			% E2'
			lmiterm([6 2 1 E2],1,1);			% E2
			lmiterm([6 2 2 E1],0.5,1);			% E1
			
			lmiterm([7 1 1 V2],4,A2,'s');		% 4*V2*A2+4*A2'*V2
			lmiterm([7 1 1 E1],TNegA2,A2,'s');	% -A2'*E1*A2
			lmiterm([7 1 1 E2],TNegA2,2,'s');	% -E2'*A2-A2'*E2
			lmiterm([7 1 2 -E2],1,1);			% E2'
			lmiterm([7 2 1 E2],1,1);			% E2
			lmiterm([7 2 2 E1],0.5,1);			% E1
			
			lmisys=getlmis;

			[tmin,xfeas]=feasp(lmisys);
			
			if tmin<0
				count1 = count1+1;
				plot(theta1,theta2,'.','MarkerEdgeColor','r','markersize',20);
				hold on;
			end;
	end			
			
				
	for squarex = 0.1:1:50
	
			theta1 = 2500/squarex;
			theta2 = 2000/squarex;
			theta3 = 2500/(100-squarex);
			theta4 = 2000/(100-squarex);
			
			A1=[-1002.5/theta1 1000/theta1;0.5/theta2 -200/theta2];
			A2=[-2.5/theta3 1000/theta3;0.5/theta4 -200/theta4];

			setlmis([])

			P1=lmivar(3,[1 2;2 3]);			% P1=[X1 X2;X2 X3]
			P2=lmivar(3,[4 2;2 3]);			% P2=[X4 X2;X2 X3]
			W=lmivar(1,[2 1]);				% W

			lmiterm([-1 1 1 P1],1,1);		% 0<P1:P1
			
			lmiterm([-2 1 1 P2],1,1);		% 0<P2:P2 
			
			lmiterm([-3 1 1 W],1,1);		% 0<W:W

			lmiterm([4 1 1 P1],1,A1,'s');	% P1*A1+A1'*P1'+W<0:P1*A1+A1*P1'
			lmiterm([4 1 1 W],1,1);			% P1*A1+A1*P1'+W<0:W

			lmiterm([5 1 1 P2],1,A2,'s');	% P2*A2+A2'*P2'+W<0:P2*A2+A2*P2'
			lmiterm([5 1 1 W],1,1);			% P2*A2+A2*P2'+W<0:W

			lmiterm([6 1 1 P1],1,A2,'s');	% P1*A2+A2'*P1'-W<0:P1*A2+A2'*P2'
			lmiterm([6 1 1 W],-1,1);		% P1*A2+A2'*P1'-W<0:-W

			lmiterm([7 1 1 P2],1,A1,'s');	% P2*A1+A1'*P2'-W<0:P2*A1+A1'*P2'
			lmiterm([7 1 1 W],-1,1);		% P2*A1+A1'*P2'-W<0:-W


			lmisys=getlmis;

			[tmin,xfeas]=feasp(lmisys);
			
			if tmin<0
				count2 = count2+1;
				plot(theta1,theta2,'o','markersize',10);
				hold on;
			end;
	end
	
	
	% for a=1:1:100
		% for b=5:0.1:20
			% A1=[-1002.5/a 1000/a;0.5/b -200/b];
			% A2=[-2.5/a 1000/a;0.5/b -200/b];
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
				% plot(a,b,'o','markersize',10);
				% hold on;
			% end;
		% end;	
	% end;

	% for a=1:1:100
		% for b=5:0.1:20
			% a=25;b=20;
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
				% plot(a,b,'.','markersize',11);
				% hold on;
			% end;
		% end;
	% end;

end

