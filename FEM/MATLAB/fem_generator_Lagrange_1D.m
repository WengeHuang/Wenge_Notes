function fem = fem_generator_Lagrange_1D(mesh, degree)
n_elem = size(mesh.t,2);
t = zeros(degree+1,n_elem); t(:,1) = (1:degree+1);
for k=2:n_elem
t(:,k) = t(:,k-1)+degree;
end
p = zeros(1, (degree+1) + (n_elem - 1)*degree);
k = 1;
elem = mesh.p(mesh.t(:,k));
h = (elem(2) - elem(1))/degree;
p(1:degree+1) = elem(1):h:elem(2);
pnt_count = degree + 1;
for k=2:n_elem
elem = mesh.p(mesh.t(:,k));
h = (elem(2) - elem(1))/degree;
p(pnt_count+1:pnt_count+degree) = elem(1)+h:h:elem(2);
pnt_count = pnt_count+degree;
end
fem = struct('p', p, 't', t, 'degree', degree);

