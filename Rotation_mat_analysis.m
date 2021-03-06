clear all;

% Creating four points emulating marker from distal segments
point1d = [1 1 1];
point2d = [2 1 1];
point3 = [2 2 1];
point4 = [1 2 1];

% Creating  points emulating marker from proximal segments
point1p = [2 3 2];
point2p = [1 3 2]; 

% Plotting 4 points
figure;
plot3(point1d(1),point1d(2),point1d(3),'or');
hold on;
plot3(point2d(1),point2d(2),point2d(3),'or');
plot3(point3(1),point3(2),point3(3),'og');
plot3(point4(1),point4(2),point4(3),'og');

plot3(point1p(1),point1p(2),point1p(3),'ob');
plot3(point2p(1),point2p(2),point2p(3),'ob');

xlabel(' x ');
ylabel(' Y ');
zlabel(' Z ');
xlim([-2 5])
ylim([-2 5])
zlim([-2 5])


% Creating distal segment axis
distal_origin  = (point1d + point2d)/2;
distal_end  = (point3 + point4)/2;

distal_y_v = distal_end - distal_origin;
distal_y_v_p = [distal_origin; distal_origin+distal_y_v];
distal_y_uv = distal_y_v./vecnorm(distal_y_v);

distal_z_v = point2d - distal_origin;
distal_z_v_p = [distal_origin; distal_origin+distal_z_v];
distal_z_uv = distal_z_v./vecnorm(distal_z_v);

distal_x_v = cross(distal_z_v, distal_y_v);
distal_x_v_p = [distal_origin; distal_origin+distal_x_v];
distal_x_uv = distal_x_v./vecnorm(distal_x_v);

distal_z_v = cross(distal_x_uv, distal_y_uv);
distal_z_v_p = [distal_origin; distal_origin+distal_z_v];
distal_z_uv = distal_z_v./vecnorm(distal_z_v);

plot3(distal_y_v_p(:,1),distal_y_v_p(:,2),distal_y_v_p(:,3),'g', 'LineWidth',1);
plot3(distal_z_v_p(:,1),distal_z_v_p(:,2),distal_z_v_p(:,3),'b', 'LineWidth',1);
plot3(distal_x_v_p(:,1),distal_x_v_p(:,2),distal_x_v_p(:,3),'r', 'LineWidth',1);

% Creating proximal segment axis
proximal_origin  = (point3 + point4)/2;
proximal_end  = (point1p + point2p)/2;

proximal_y_v = proximal_end - proximal_origin;
proximal_y_v_p = [proximal_origin; proximal_origin+proximal_y_v];
proximal_y_uv = proximal_y_v./vecnorm(proximal_y_v);

proximal_z_v = point3 - proximal_origin;
proximal_z_v_p = [proximal_origin; proximal_origin+proximal_z_v];
proximal_z_uv = proximal_z_v./vecnorm(proximal_z_v);

proximal_x_v = cross(proximal_z_v, proximal_y_v);
proximal_x_v_p = [proximal_origin; proximal_origin+proximal_x_v];
proximal_x_uv = proximal_x_v./vecnorm(proximal_x_v);

proximal_z_v = cross(proximal_x_uv, proximal_y_uv);
proximal_z_v_p = [proximal_origin; proximal_origin+proximal_z_v];
proximal_z_uv = proximal_z_v./vecnorm(proximal_z_v);

plot3(proximal_y_v_p(:,1),proximal_y_v_p(:,2),proximal_y_v_p(:,3),'g', 'LineWidth',1);
plot3(proximal_z_v_p(:,1),proximal_z_v_p(:,2),proximal_z_v_p(:,3),'b', 'LineWidth',1);
plot3(proximal_x_v_p(:,1),proximal_x_v_p(:,2),proximal_x_v_p(:,3),'r', 'LineWidth',1);

% Creating rotation matrices
rot_dist = [distal_x_uv' distal_y_uv' distal_z_uv'];
rot_prox = [proximal_x_uv' proximal_y_uv' proximal_z_uv'];

% Combining the proximal and distal rotation matrix
rot_prox_dist = rot_prox' * rot_dist;
% rot_prox_dist = rot_dist' * rot_prox;

% extracting the unit vectors from the new rotation matrix
rot_x_uv = rot_prox_dist(:,1)';
rot_y_uv = rot_prox_dist(:,2)';
rot_z_uv = rot_prox_dist(:,3)';

% plotting the unit vectors
rot_x_p = [distal_origin; distal_origin+rot_x_uv];
rot_y_p = [distal_origin; distal_origin+rot_y_uv];
rot_z_p = [distal_origin; distal_origin+rot_z_uv];

pause(10)
plot3(rot_x_p(:,1),rot_x_p(:,2),rot_x_p(:,3),'--r', 'LineWidth',0.5);
plot3(rot_y_p(:,1),rot_y_p(:,2),rot_y_p(:,3),'--g', 'LineWidth',0.5);
plot3(rot_z_p(:,1),rot_z_p(:,2),rot_z_p(:,3),'--b', 'LineWidth',0.5);

% computing the rotation angles using ZXY euler sequence
beta = atan2(sqrt((rot_prox_dist(1,2)^2)+(rot_prox_dist(2,2)^2)), rot_prox_dist(3,2));
alpha = atan2(-rot_prox_dist(1, 2),rot_prox_dist(2,2));
gamma = atan2(-rot_prox_dist(3,1),rot_prox_dist(3,3));

beta_deg = rad2deg(beta)
alpha_deg = rad2deg(alpha)
gamma_deg = rad2deg(gamma)

