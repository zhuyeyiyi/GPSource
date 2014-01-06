function [cnt1 cnt2 cnt3 P1 V21 V22 V31 V32 E31 E32]=statedexa1()

	clc;
	close all;
	clear all;
	
	cnt1 = 0;
	cnt2 = 0;
	cnt3 = 0;
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% A1=[-2005/50 40;1/40 -10];
	% A2=[-1/10 40;1/40 -10];

	A1=[-1007/500 2;50 -10];
	A2=[-7/500 2;50 -10];
	
	setlmis([])

	P=lmivar(1,[2 1]);
	
	lmiterm([-1 1 1 P],1,1);

	lmiterm([2 1 1 P],1,A1,'s');
	lmiterm([3 1 1 P],1,A2,'s');

	lmisys=getlmis;
	[tmin,xfeas]=feasp(lmisys);
	cnt1 = tmin;
	if(tmin < 0)
		P1 = dec2mat(lmisys,xfeas,P);
	end

	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	setlmis([]);

	P1=lmivar(3,[1 2;2 3]);
	P2=lmivar(3,[4 2;2 3]);
	W=lmivar(1,[2 1]);

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
	cnt2 = tmin;
	if(tmin < 0)
		V21 = dec2mat(lmisys,xfeas,P1);
		V22 = dec2mat(lmisys,xfeas,P2);
	end
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
	lmiterm([7 1 1 E2],TNegA2,2,'s');	% -2E2'*A2-2A2'*E2
	lmiterm([7 1 2 -E2],1,1);			% E2'
	lmiterm([7 2 1 E2],1,1);			% E2
	lmiterm([7 2 2 E1],0.5,1);			% E1
		
	lmisys=getlmis;
	[tmin,xfeas]=feasp(lmisys);
	cnt3 = tmin;
	if(tmin < 0)
		V31 = dec2mat(lmisys,xfeas,V1);
		V32 = dec2mat(lmisys,xfeas,V2);
		E31 = dec2mat(lmisys,xfeas,E1);
		E32 = dec2mat(lmisys,xfeas,E2);		
	end
	
	
end