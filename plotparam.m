function plotparam()


	% b     blue          .     point              -     solid
		   % g     green         o     circle             :     dotted
		   % r     red           x     x-mark             -.    dashdot 
		   % c     cyan          +     plus               --    dashed   
		   % m     magenta       *     star             (none)  no line
		   % y     yellow        s     square
		   % k     black         d     diamond
		   % w     white         v     triangle (down)
							   % ^     triangle (up)
							   % <     triangle (left)
							   % >     triangle (right)
							   % p     pentagram
							   % h     hexagram
							   
	param0 = load('param0.txt');
	param1 = load('param1.txt');
	param2 = load('param2.txt');
	paramd = load('paramd.txt');

	figure;
	
	% plot(param2(:,1),param2(:,2),'s','markersize',12);
	% hold on;
	
	% plot(param0(:,1),param0(:,2),'.','markersize',6);
	% hold on;
	
	plot(param1(:,1),param1(:,2),'o','markersize',10);
	hold on;

	plot(paramd(:,1),paramd(:,2),'.','markersize',12);
	hold on;
	
	xlabel('\alpha');
	ylabel('\beta');
	legend('Theorem 1','Theorem 2','Theorem 3','Theorem 4','location','northwest');
	%exportfig(fig, 'fig2.eps', 'FontMode', 'fixed','FontSize', 10, 'color', 'cmyk' ); 
	exportfig(gcf,'test.eps','bounds','tight','color','cmyk');
	applytofig(gcf,'bounds','tight','color','cmyk');
	print(gcf,'-depsc2','param.eps');
end