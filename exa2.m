function [count0 count1 count2 count3]=exa2()
	clc;
	clear all;
	close all;

	count0 = 0;
	count1 = 0;
	count2 = 0;
	count3 = 0;

	for beta = -2:1:2
		for alpha =  -20:1:10

		A1=[-5 -4;-1 alpha];
		A2=[-4 -4;0.6*beta-0.4 0.6*alpha-0.8];
		A3=[-3 -4;0.4*beta-0.6 0.4*alpha-1.2];
		A4=[-2 -4;beta -2];

		setlmis([]);
			
		V1=lmivar(3,[1 2;3 4]);				% V1=[X1 X2;X2 X3]
		V2=lmivar(3,[1 2;3 5]);				% V2=[X4 X2;X2 X3]
		V3=lmivar(3,[6 2;3 7]);
		V4=lmivar(3,[8 2;3 7]);

		lamda12 = lmivar(3,8+[1 2;3 4]);
		lamda13 = lmivar(3,12+[1 2;3 4]);
		lamda14 = lmivar(3,16+[1 2;3 4]);
		lamda21 = lmivar(3,20+[1 2;3 4]);
		lamda23 = lmivar(3,24+[1 2;3 4]);
		lamda24 = lmivar(3,28+[1 2;3 4]);
		lamda31 = lmivar(3,32+[1 2;3 4]);
		lamda32 = lmivar(3,36+[1 2;3 4]);
		lamda34 = lmivar(3,40+[1 2;3 4]);
		lamda41 = lmivar(3,44+[1 2;3 4]);
		lamda42 = lmivar(3,48+[1 2;3 4]);
		lamda43 = lmivar(3,52+[1 2;3 4]);
		
		lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
		lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2
		lmiterm([-3 1 1 V3],1/2,1,'s');		% 0<V3:V3
		lmiterm([-4 1 1 V4],1/2,1,'s');		% 0<V4:V4

		lmiterm([ 5 1 1 -V1],1,A2,'s');
		lmiterm([-5 1 1 lamda12],1/2,1,'s');
		lmiterm([ 6 1 1 -V1],1,A3,'s');
		lmiterm([-6 1 1 lamda13],1/2,1,'s');
		lmiterm([ 7 1 1 -V1],1,A4,'s');
		lmiterm([-7 1 1 lamda14],1/2,1,'s');

		lmiterm([ 8 1 1 -V2],1,A1,'s');
		lmiterm([-8 1 1 lamda21],1/2,1,'s');
		lmiterm([ 9 1 1 -V2],1,A3,'s');
		lmiterm([-9 1 1 lamda23],1/2,1,'s');
		lmiterm([ 10 1 1 -V2],1,A4,'s');
		lmiterm([-10 1 1 lamda24],1/2,1,'s');

		lmiterm([ 11 1 1 -V3],1,A1,'s');
		lmiterm([-11 1 1 lamda31],1/2,1,'s');
		lmiterm([ 12 1 1 -V3],1,A2,'s');
		lmiterm([-12 1 1 lamda32],1/2,1,'s');
		lmiterm([ 13 1 1 -V3],1,A4,'s');
		lmiterm([-13 1 1 lamda34],1/2,1,'s');

		lmiterm([ 14 1 1 -V4],1,A1,'s');
		lmiterm([-14 1 1 lamda41],1/2,1,'s');
		lmiterm([ 15 1 1 -V4],1,A2,'s');
		lmiterm([-15 1 1 lamda42],1/2,1,'s');
		lmiterm([ 16 1 1 -V4],1,A3,'s');
		lmiterm([-16 1 1 lamda43],1/2,1,'s');

		lmiterm([ 17 1 1 -V1],1,A1,'s');		
		lmiterm([ 17 1 2  lamda12],1/2,1);
		lmiterm([ 17 1 2 -lamda21],1/2,1);
		lmiterm([ 17 1 3  lamda13],1/2,1);
		lmiterm([ 17 1 3 -lamda31],1/2,1);			
		lmiterm([ 17 1 4  lamda14],1/2,1);
		lmiterm([ 17 1 4 -lamda41],1/2,1);


		lmiterm([ 17 2 1  lamda21],1/2,1);
		lmiterm([ 17 2 1 -lamda12],1/2,1);
		lmiterm([ 17 2 2 -V2],1,A2,'s');		
		lmiterm([ 17 2 3  lamda23],1/2,1);
		lmiterm([ 17 2 3 -lamda32],1/2,1);
		lmiterm([ 17 2 4  lamda24],1/2,1);
		lmiterm([ 17 2 4 -lamda42],1/2,1);


		lmiterm([ 17 3 1  lamda31],1/2,1);
		lmiterm([ 17 3 1 -lamda13],1/2,1);
		lmiterm([ 17 3 2  lamda32],1/2,1);
		lmiterm([ 17 3 2 -lamda23],1/2,1);
		lmiterm([ 17 3 3 -V3],1,A3,'s');		
		lmiterm([ 17 3 4  lamda34],1/2,1);
		lmiterm([ 17 3 4 -lamda43],1/2,1);


		lmiterm([ 17 4 1  lamda41],1/2,1);
		lmiterm([ 17 4 1 -lamda14],1/2,1);
		lmiterm([ 17 4 2  lamda42],1/2,1);
		lmiterm([ 17 4 2 -lamda24],1/2,1);
		lmiterm([ 17 4 3  lamda43],1/2,1);
		lmiterm([ 17 4 3 -lamda34],1/2,1);
		lmiterm([ 17 4 4 -V4],1,A4,'s');

		
		
		lmisys=getlmis;
		[tmin,xfeas]=feasp(lmisys);

		if tmin<0
			count0 = count0 + 1;
			plot(alpha,beta,'o','markersize',8);
			hold on;
		end
		
		end
	end

	
	
	for beta = -2:1:2
		for alpha =  -20:1:10
		
		A1=[-5 -4;-1 alpha];
		A2=[-4 -4;0.6*beta-0.4 0.6*alpha-0.8];
		A3=[-3 -4;0.4*beta-0.6 0.4*alpha-1.2];
		A4=[-2 -4;beta -2];

		setlmis([]);
			
		V1=lmivar(3,[1 2;3 4]);				% V1=[X1 X2;X2 X3]
		V2=lmivar(3,[1 2;3 5]);				% V2=[X4 X2;X2 X3]
		V3=lmivar(3,[6 2;3 7]);
		V4=lmivar(3,[8 2;3 7]);
		 W=lmivar(1,[2 1]);

		lmiterm([-1 1 1 V1],1/2,1,'s');		% 0<V1:V1
		lmiterm([-2 1 1 V2],1/2,1,'s');		% 0<V2:V2
		lmiterm([-3 1 1 V3],1/2,1,'s');		% 0<V3:V3
		lmiterm([-4 1 1 V4],1/2,1,'s');		% 0<V4:V4
		lmiterm([-5 1 1  W],1,1);			% 0<W :W
		
		lmiterm([ 6 1 1 -V1],1,A2,'s');		% V1'*A2+A2'*V1<W:V1'*A2+A2'*V1
		lmiterm([-6 1 1   W],1,1);			% V1'*A2+A2'*V1<W:W		
		lmiterm([ 7 1 1 -V1],1,A3,'s');		% V1'*A3+A3'*V1<W:V1'*A3+A3'*V1
		lmiterm([-7 1 1   W],1,1);			% V1'*A3+A3'*V1<W:W		
		lmiterm([ 8 1 1 -V1],1,A4,'s');		% V1'*A4+A4'*V1<W:V1'*A4+A4'*V1
		lmiterm([-8 1 1   W],1,1);			% V1'*A4+A4'*V1<W:W


		lmiterm([ 9 1 1 -V2],1,A1,'s');		% V2'*A1+A1'*V2<W:V2'*A1+A1'*V2
		lmiterm([-9 1 1   W],1,1);			% V2'*A1+A1'*V2<W:W
		lmiterm([ 10 1 1 -V2],1,A3,'s');	% V1'*A3+A3'*V1<W:V1'*A3+A3'*V1
		lmiterm([-10 1 1  W],1,1);			% V1'*A3+A3'*V1<W:W
		lmiterm([ 11 1 1 -V2],1,A4,'s');	% V1'*A4+A4'*V1<W:V1'*A4+A4'*V1
		lmiterm([-11 1 1  W],1,1);			% V1'*A4+A4'*V1<W:W
		
		
		lmiterm([ 12 1 1 -V3],1,A1,'s');	% V2'*A1+A1'*V2<W:V2'*A1+A1'*V2
		lmiterm([-12 1 1   W],1,1);			% V2'*A1+A1'*V2<W:W
		lmiterm([ 13 1 1 -V3],1,A2,'s');	% V1'*A3+A3'*V1<W:V1'*A3+A3'*V1
		lmiterm([-13 1 1   W],1,1);			% V1'*A3+A3'*V1<W:W
		lmiterm([ 14 1 1 -V3],1,A4,'s');	% V1'*A4+A4'*V1<W:V1'*A4+A4'*V1
		lmiterm([-14 1 1   W],1,1);			% V1'*A4+A4'*V1<W:W
		

		lmiterm([ 15 1 1 -V4],1,A1,'s');	% V2'*A1+A1'*V2<W:V2'*A1+A1'*V2
		lmiterm([-15 1 1   W],1,1);			% V2'*A1+A1'*V2<W:W
		lmiterm([ 16 1 1 -V4],1,A2,'s');	% V1'*A3+A3'*V1<W:V1'*A3+A3'*V1
		lmiterm([-16 1 1   W],1,1);			% V1'*A3+A3'*V1<W:W		
		lmiterm([ 17 1 1 -V4],1,A3,'s');	% V1'*A4+A4'*V1<W:V1'*A4+A4'*V1
		lmiterm([-17 1 1   W],1,1);			% V1'*A4+A4'*V1<W:W
		
		
		lmiterm([ 18 1 1 -V1],1,A1,'s');	% V2'*A1+A1'*V2<W:V2'*A1+A1'*V2
		lmiterm([-18 1 1   W],-3,1);		% V2'*A1+A1'*V2<W:W
		lmiterm([ 19 1 1 -V2],1,A2,'s');	% V1'*A3+A3'*V1<W:V1'*A3+A3'*V1
		lmiterm([-19 1 1   W],-3,1);		% V1'*A3+A3'*V1<W:W		
		lmiterm([ 20 1 1 -V3],1,A3,'s');	% V1'*A4+A4'*V1<W:V1'*A4+A4'*V1
		lmiterm([-20 1 1   W],-3,1);		% V1'*A4+A4'*V1<W:W
		lmiterm([ 21 1 1 -V4],1,A4,'s');	% V1'*A4+A4'*V1<W:V1'*A4+A4'*V1
		lmiterm([-21 1 1   W],-3,1);		% V1'*A4+A4'*V1<W:W
		
		
		
		lmisys=getlmis;
		[tmin,xfeas]=feasp(lmisys);

		if tmin<0
			count2 = count2 + 1;
			plot(alpha,beta,'.','markersize',8);
			hold on;
		end
		
		end
	end
		
	for beta = -2:1:2
		for alpha =  -20:1:10
		
			A1=[-5 -4;-1 alpha];
			A2=[-4 -4;0.6*beta-0.4 0.6*alpha-0.8];
			A3=[-3 -4;0.4*beta-0.6 0.4*alpha-1.2];
			A4=[-2 -4;beta -2];

			setlmis([]);

			P=lmivar(3,[1 2;2 3]);

			lmiterm([-1 1 1 P],1,1);

			lmiterm([2 1 1 P],1,A1,'s');
			lmiterm([3 1 1 P],1,A2,'s');
			lmiterm([4 1 1 P],1,A3,'s');
			lmiterm([5 1 1 P],1,A4,'s');

			lmisys=getlmis;
			[tmin,xfeas]=feasp(lmisys);

			if tmin<0
				count3 = count3 + 1;
				plot(alpha,beta,'-rs','markersize',5);
				hold on;
			end
	
		end
	end	
	
end