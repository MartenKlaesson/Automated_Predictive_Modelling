function [JGrad] = JGrad(x,m1,m2,A1,A2)

JGrad=(A1+A1')*(x-m1)*(x-m2)'*A2*(x-m2)+(A2+A2')*(x-m2)*(x-m1)'*A1*(x-m1)

end

