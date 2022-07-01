% this procedure draws earth on a 3d plot
%
% Function assumes (km) as distance unit.
% INPUTS:
% x,y,z coordinates of Earth center in (km)

function [] = draw_sphere(x,y,z, radius)

if nargin < 4
  radius =   6371;
end

load('topo.mat','topo','topomap1');
[a,b,c] = sphere(30);
a = x + a * radius;
b = y + b * radius;
c = z + c * radius;

axis equal;

props.AmbientStrength = 0;
props.DiffuseStrength = 1;
props.SpecularColorReflectance = .5;
props.SpecularExponent = 400;
props.SpecularStrength = 1;
props.FaceColor= [0.9 0.9 1];
props.EdgeColor = 'blue';
props.FaceLighting = 'phong';
surface(a,b,c, props);

% format figure
view(3);

return;