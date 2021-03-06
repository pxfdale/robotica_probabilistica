function weight = measurement_model(z, x, l)
    % Computes the observation likelihood of all particles.
    %
    % The employed sensor model is range only.
    %
    % z: set of landmark observations. Each observation contains the id of the landmark observed in z(i).id and the measured range in z(i).range.
    % x: set of current particles
    % l: map of the environment composed of all landmarks
    sigma = [0.2];
    weight = ones(size(x, 1), 1);

    if size(z, 2) == 0
        return
    endif
    
    for i = 1:size(z, 2)
        landmark_position = [l(z(i).id).x, l(z(i).id).y];
        measurement_range = [z(i).range];
        %% TODO: compute weight
        %%%% Esto es proporsional a P(Zt | Xt_i
        sigma_z=[0.2];
        % Distancias de las antenas a cada sede (Heras; P. Colon)
        d_pos2l=[];
        d_pos2l=[sqrt((x(:,1)-landmark_position(1)).**2+(x(:,2)-landmark_position(2)).**2)];
        delta_d=[abs(d_pos2l(:)-measurement_range)];% delta_d = T0x0 T0x1 ...
        % Probabilidad  P(d0^d1|particula)=P(d0|particula1)*P(d1|particula1)...
        %                                 | => 1-P(X<delta_d)+P(X< -delta_d)
        prob_x=[(1-normcdf(delta_d(:),0,sigma_z(1))+normcdf(-delta_d(:),0,sigma_z(1)))];
        weight=weight.*prob_x;
    endfor
  
    weight = weight ./ size(z, 2);
end
