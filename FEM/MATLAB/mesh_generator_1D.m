function mesh = mesh_generator_1D(domain, n)
x_l = domain(1); x_r = domain(2);
p = x_l:(x_r - x_l)/n:x_r;
t = zeros(2,n); t(:,1) = [1;2];
for i=2:n
t(:,i) = t(:,i-1) + 1;
end
e = zeros(3, n+1);
e(1,:) = 1:n+1; e(2,:) = 0:n; e(3,:) = [1:n,0];
mesh = struct('p', p, 't', t, 'e',e);

