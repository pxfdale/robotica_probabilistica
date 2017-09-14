function [p_n]=Ej3_diffdriver(x,y,theta,v_l,v_r,t,l)
  if v_l==v_r
    v_l=v_l+0.01*(rand-0.5);
  endif
  r=l/2*(v_l+v_r)/(v_r-v_l)
  w=(v_r-v_l)/l
  v=(v_l+v_r)
  ICC=[x-r*sin(theta), y-r*cos(theta)]
  rot=[cos(w*t) -sin(w*t) 0;...
       sin(w*t)  cos(w*t) 0;...
          0         0     1];
  p_n= rot*[x-ICC(1) y-ICC(2) theta]'+[ICC(1) ICC(2) w*t]'
endfunction
