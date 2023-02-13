function u = FE_evaluation_1D_Lagrange(x, u_fe_loc, elem, degree, d_index)
u = zeros(size(x));
for shape_index = 1:degree + 1
u = u + u_fe_loc(shape_index)*shape_fun_1D_Lagrange(x, elem, ...
degree, shape_index, d_index);
end
