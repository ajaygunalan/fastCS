clc;clear all;close all;
%%
%----------------------------------------------------------------------------------%
%  1-DÐÅºÅÑ¹Ëõ´«¸ÐµÄÊµÏÖ(l1-MAGICºÍl1_ls½âl1ÎÊÌâ)   
%  ²âÁ¿ÊýM>=K*log(N/K),KÊÇÏ¡Êè¶È,NÐÅºÅ³¤¶È,¿ÉÒÔ½üºõÍêÈ«ÖØ¹¹
%  ±à³ÌÈË--Î÷ÄÏ½»Í¨´óÑ§Ç£Òý¶¯Á¦¹ú¼ÒÖØµãÊµÑéÊÒ ºÎÁõ  Email: aresmiki@163.com
%  ±à³ÌÊ±¼ä£º2017Äê04ÔÂ26ÈÕ
%---------------------------------------------------------------------------------%
%% 1. ¹¹ÔìÐÅºÅ
fs=100;     %²ÉÑùÆµÂÊ
N=100;    %ÐÅºÅ³¤¶È
t=0:1/fs:(N-1)/fs; 
x2=cos(2*pi*50*t);  %¹¹ÔìÐÅºÅ
%% 2. ÀëÉ¢ÓàÏÒ±ä»»£¬²¢½«ºÜÐ¡ÖµÉèÖÃÎª0£¬È·±£Ï¡Êè¶È£¬²¢ÖØ¹¹»ØÐÅºÅ
% C=gen_dct(N);
C=dctmtx(N);     %ÀëÉ¢ÓàÏÒ±ä»»¾ØÕó
cx=C*x2';
cx(find(abs(cx)<0.5))=0;   %½«½ÏÐ¡·ÖÁ¿ÖÃÁã£¬ËäÈ»Ó°ÏìÔ­Ê¼ÐÅºÅ£¬µ«È·±£ÁËÏ¡Êè¶È
% figure
% plot([x2',C'*cx])
x2=C'*cx;    %ÖØ¹¹»ØÐÅºÅ£¬¸ÃÐÅºÅµÄÀëÉ¢ÓàÏÒ±Ø¶¨Ï¡Êè
x2=x2';
%% 3. ²âÁ¿ÐÅºÅ   
% ÓÃ44²âÁ¿ÐÅºÅµÄÊý¾Ý»Ö¸´100¸öµãµÄÊý¾Ý£¬°´ÕÕÄÎ¿üË¹ÌØNyquist²ÉÑù¶¨Àí£¬1sÐè²ÉÑù100¸öµã²ÅÄÜ»Ö¸´Ô­Ê¼ÐÅºÅ£¬
% µ«ÊÇCSÀíÂÛÖ»ÐèÒª44¸öµãµÄÊý¾Ý¾ÍÄÜ»Ö¸´£¬ÕâÍêÈ«Í»ÆÆÁËNyquist²ÉÑù¶¨ÀíµÄÏÞÖÆ¡£

K=length(find(abs(cx)>0.5));   %ÐÅºÅÏ¡Êè¶È,²é¿´ÀëÉ¢ÓàÏÒ±ä»»µÄÍ¼
M=2*ceil(K*log(N/K)); %K=9ÊÇ£¬¸ÃÖµÎª22£¬²âÁ¿Êý,²âÁ¿¾ØÕóÑ¹Ëõ³Ì¶È£¬¾­Ñé¹«Ê½
randn('state',4)
Phi=randn(M,N);  %  ²âÁ¿¾ØÕó(¸ßË¹·Ö²¼°×ÔëÉù)
Phi=orth(Phi')';    %Õý½»»¯
y=Phi*x2.';     %  »ñµÃÏßÐÔ²âÁ¿ ---Ö»ÓÐ44¸öµã£¬

%% 4. l1ÎÊÌâ×îÐ¡»¯ l1-Magic¹¤¾ßÏä 
% l1eq_pd·½·¨½âµÄÎÊÌâÊÇÈçÏÂÓÅ»¯ÎÊÌâ
% min_x ||x||_1  s.t.  Ax = b
%
A=Phi*C';  
% x0=A'*y;   %×îÐ¡¶þ³Ë×÷Îªl1×îÐ¡»¯µÄ³õÊ¼Öµ¹À¼Æ
% ÓÃl1-MAGICµÄMATLAB¹¤¾ßÏä½âl1×îÐ¡»¯ÎÊÌâ
% xh1=l1eq_pd(x0,A,[],y,1e-3);
xh1=l1eq_pd(zeros(N,1),A,[],y,1e-3);  %¿ÉÒÔ²»¸ø³õÊ¼µÄ¹À¼Æ
%%  l1ÎÊÌâ×îÐ¡»¯  l1_ls¹¤¾ßÏä
% l1_ls½âµÄÓÅ»¯ÎÊÌâÊÇ
% minimize ||A*x-y||^2 + lambda*sum|x_i|,
%
lambda  = 0.01; % ÕýÔò»¯²ÎÊý
rel_tol = 1e-3; % Ä¿±êÏà¶Ô¶ÔÅ¼¼äÏ¶
quiet=1;   %²»Êä³öÖÐ¼ä½á¹û
[xh2,status]=l1_ls(A,y,lambda,rel_tol,quiet);
% At=A';
% [xh2,status]=l1_ls(A,At,M,N,y,lambda,rel_tol,quiet);
%% 5.»Ö¸´ÐÅºÅºÍÔ­Ê¼ÐÅºÅ±È½Ï
figure
plot(t,C'*xh1,'k.-',t,x2,'r-')
xlim([0,t(end)])
legend('l1-MAGIC»Ö¸´ÐÅºÅ','Ô­Ê¼ÐÅºÅ')

figure
plot(t,C'*xh2,'k.-',t,x2,'r-')
xlim([0,t(end)])
legend('l1-ls»Ö¸´ÐÅºÅ','Ô­Ê¼ÐÅºÅ')

%% 6. ISTA·½·¨½âl1×îÐ¡»¯ÎÊÌâ
A=Phi*C';  
[theta,erro_rnn]=CS_ISTA( y,A,0.05);
figure
plot(erro_rnn,'-*')
legend('ISTAÎó²î')
%% 7.»Ö¸´ÐÅºÅºÍÔ­Ê¼ÐÅºÅ±È½Ï
figure
plot(t,C'*theta,'k.-',t,x2,'r-')
xlim([0,t(end)])
legend('ISTA»Ö¸´ÐÅºÅ','Ô­Ê¼ÐÅºÅ')

%% 8. FISTA·½·¨½âl1×îÐ¡»¯ÎÊÌâ
A=Phi*C';  
[theta,erro_rnn]=CS_FISTA( y,A,0.05);
figure
plot(erro_rnn,'-*')
legend('FISTAÎó²î')
%% 9.»Ö¸´ÐÅºÅºÍÔ­Ê¼ÐÅºÅ±È½Ï
figure
plot(t,C'*theta,'k.-',t,x2,'r-')
xlim([0,t(end)])
legend('FISTA»Ö¸´ÐÅºÅ','Ô­Ê¼ÐÅºÅ')
%% 10.½âL0ÎÊÌâ£¬ÓÃ½üËÆ·½·¨£¬Ò²¾ÍÊÇLp·½·¨  SL0Ëã·¨
% A*x=y, using  Smoothed L0
% minimize ||x||_0
% subject to A*x=y
A=Phi*C';  
[theta]=CS_SL0( y,A,0.001,0.9,1,4);
figure
plot(t,C'*theta,'k.-',t,x2,'r-')
xlim([0,t(end)])
legend('SL0»Ö¸´ÐÅºÅ','Ô­Ê¼ÐÅºÅ')
