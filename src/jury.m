function [T] = jury(P)
% Use:
%   T = jury([an an-1 ... a1 a0])
%   were:
%           T is the Jury table
%           [an an-1 ... a1 a0] is the characteristic polinomial
%
% The Jury stability criterion is a method of determining the stability of
% a linear discrete time system by analysis of the coefficients of its 
% characteristic equation. The Jury stability criterion requires that the
% system poles are located inside the unit circle centered at the origin.
%
% (c) Riccardo Agnesi
% Rome, Italy
% 20/6/2019
%-------------------------------------------------------------------------- argin test 
errore=0;
if(nargin > 1 || nargin == 0)
    errore=1;
else
    [r c]=size(P);
    if(r>1 || c<2)
        errore =1;
    end
end
if(errore)
    fprintf('\n\nInput error. Use:\n')
    fprintf('\tjuryC([an an-1 ... a1 a0])\n');
    fprintf('OR\n');
    fprintf('\tT = juryC([an an-1 ... a1 a0])\n\n');
    return
end
%-------------------------------------------------------------------------- polynomial order
fprintf('\n*****************************************\n');
fprintf('\tPolynomial under test:\n\n'); 
%------------------------------------------------------------------------
an = P(1);
if(an<0)
    P=P*-1;
end
n = print_poly(P);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
if(n<=2),
    %----------------------------------------------------------------------
    fprintf('\n\nPolynomial order = %d THEN\n\n', n);
    fprintf('necessary and sufficient conditions:\n\n');
    %----------------------------------------------------------------------
    stability = test3(P,n);
    %----------------------------------------------------------------------
    if (stability),
        fprintf('\nThe system is stable. The roots are:');
    else
        fprintf('\n*** The system IS NOT STABLE ***. \n\nThe roots are:\n');
    end
    %----------------------------------------------------------------------
else,
    %----------------------------------------------------------------------
    fprintf('\n\nPolynomial order = %d \n\n', n);
    fprintf('necessary conditions:\n\n');
    %----------------------------------------------------------------------
    stability = test3(P,n);
    %----------------------------------------------------------------------
    if(stability)
        fprintf('\nThe necessary conditions are met. \n\n');
        fprintf('It is necessary to build the Jury table.\n\n');
        %------------------------------------------------------------------
        T=jury_table(P,n);
        print_jury_table(T,n);
        %------------------------------------------------------------------
        fprintf('\t\tAdditional condition to test = %d \n\n', n-2)
        stability = add_test(T,n);
        %------------------------------------------------------------------
        if(stability)
            fprintf('\nThe system is stable. The roots are:\n');
        else
            fprintf('\n*** The system IS NOT STABLE ***. \n\nThe roots are:\n');
        end
        %------------------------------------------------------------------
    else
        fprintf('\n*** The system IS NOT STABLE because the necessary conditions are not met***. \n\nThe roots are:\n');
    end
    %----------------------------------------------------------------------
end
print_roots(P);
end
%-------------------------------------------------------------------------- SUPPORT
function v = eval_poly(P,z)
%
[r,c]=size(P);
n=c-1;
v=0;
for i=0:c-1,
    v = v + P(1,i+1)*z^(n-i);
end
end
function T = jury_table(P,n)
    T=zeros(2*(n-1)-1,n+1);                                               % n-1 rows, but tha last is single
    
    T(2,:)=P;
    T(1,:)=fliplr(P);
    
    T(3,:)= T(1,1) * T(1,:) - T(2,1) * T(2,:);
    %----------------------------------------------------------------------
    for (j=2:(n-2)),
        [r,c]=size(T(2*j-1,:));
        T(2*j,1:c-1)=fliplr(T(2*j-1,1:c-1));
        T(2*j+1,:)=T(2*j-1,1) * T(2*j-1,:) - T(2*j,1)* T(2*j,:);
    end
    %----------------------------------------------------------------------
end
function print_jury_table(T,n)
    fprintf('   Row\t\t Table\n\n');
    for (i=0:n-4+1)
        %------------------------------------------------------------------
        fprintf('\t%d\t| ',n-i);
        for(j=1:n+1-i)
            fprintf('\t%6.3g',T(i*2 + 1,j));
        end
        fprintf('\n');
        %------------------------------------------------------------------
        fprintf('\t\t| ');
        for(j=1:n+1-i)
            fprintf('\t%6.3g',T(i*2 + 2,j));
        end
        fprintf('\n');
        %------------------------------------------------------------------
        fprintf('\t-------');
        for(j=1:n+1-i)
            fprintf('\t-------');
        end
        fprintf('---\n');
        %------------------------------------------------------------------
    end
    fprintf('\t%d\t| ',2);
    for(j=1:3)
        fprintf('\t%6.3g',T((n-2)*2 + 1,j));
    end
    fprintf('\t\n\n\n');
end
function stability = test3(P,n)
    stability=1;
    test_string = ['FALSE' ; 'TRUE '];
    %----------------------------------------------------------------------
    r=eval_poly(P,1);
    test = (r > 0);
   
    fprintf('\t       P(z = 1)  > 0       =>   %4.3g > 0     => %s\n',r,test_string(1 + test,:));
    if(test == 0)
        stability=0;
    end
    %----------------------------------------------------------------------
    r = (-1)^n * eval_poly(P,-1);
    test = (r > 0);
    
    fprintf('\t     n \n');
    fprintf('\t (-1)  P(z = -1) > 0       =>   %4.3g > 0     => %s\n\n',r,test_string(1 + test,:));
    if(test == 0)
        stability=0;
    end
    %----------------------------------------------------------------------
    test = (abs(P(1,1)) > abs(P(1,n+1)));
    
    fprintf('\t            |an| > |a0|    => |%4.3g| > |%4.3g|   => %s\n',P(1,1),P(1,n+1),test_string(1 + test,:)); 
    if(test == 0)
        stability=0;
    end
end
function stability = add_test(T,n)
    test=zeros(n-2);
    stability=1;
    test_string = ['FALSE' ; 'TRUE '];
    
    for(i=1:n-2),
        riga=2*i+1;
        ultima_colonna= n + 1 - i;
        test(i) = (abs(T(riga,1)) > abs(T(riga,ultima_colonna)));
        fprintf('\t| %6.3g | > | %6.3g | \t\t => %s \n', T(riga,1),T(riga,ultima_colonna), test_string(1 +test(i),:));
        if (test(i) == 0),
            stability = 0;
        end
    end
    %fprintf('\n\n');
end
function print_roots(P)
    car ='';
    z=roots(P);
    [r,c]=size(z);
    for(i=1:r),
        if(imag(z(i)) == 0)
            fprintf('\t z%d = %4.3f \t\t\t\t\t=> modulus = %4.3f\n',i,real(z(i)),abs(z(i)));
        else
            if(imag(z(i)) > 0)
                car = '+';
            else
                car = '';
            end
            fprintf('\t z%d = %4.3f %c%4.3f i\t\t\t=> modulus = %4.3f\n',i,real(z(i)),car,imag(z(i)),abs(z(i)));
        end
    end
end
function n = print_poly(P)
%
    [r,c]=size(P);
    n = c-1;
    
    if(P(1,1) ~= 1)
        basi = sprintf('%4.3g z',P(1,1));
    else
        basi = sprintf('z');
    end
    
    [t nb]=size(basi);
    esponenti = [blanks(nb) sprintf('%d',c-1)];
    for(i=2:c-1),
        if(P(1,i) ~= 0 )
            temp = sprintf('%4.3g z',P(1,i));
            basi = [basi ' + ' temp];
            [t nb]=size(temp);
            if((c-i) ~= 1)
                esponenti = [esponenti blanks(nb+2) sprintf('%d',c-i)];
            end
        end
    end
    if(P(1,c) ~= 0 )
        basi = [basi ' + ' sprintf('%4.3g',P(1,c)) ];
    end
    fprintf('\t%s\n',esponenti)
    fprintf('\t%s\n',basi)
end
