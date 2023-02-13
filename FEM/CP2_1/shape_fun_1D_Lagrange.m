function f = shape_fun_1D_Lagrange(x, elem, degree, shape_index, d_index)
t = (2/(elem(2)-elem(1)))*(x-elem(1)) - 1;
f = ((2/(elem(2)-elem(1)))^d_index)*shape_fun_1D_Lagrange_ref(t,shape_index, d_index, degree);
end
