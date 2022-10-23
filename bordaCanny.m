
function Ib = bordaCanny(I,w,th,tl)
I2 = I;
sig = (w-1)/6;
K = fspecial('gaussian',w,sig);


I2 = filter2(K,I2,'same');



ku =[-1 0 1;-2 0 2;-1 0 1];
kv = ku';

Iu = filter2(ku,I2,'same');
Iv = filter2(kv,I2,'same');


M = sqrt(Iu.^2 + Iv.^2);



p = atan2d(Iv, Iu);

Gn = zeros(size(I2));

[M1,N,l] = size(I); 

for j = 2:M1-1
     for i = 2:N-1
         
         if(p(j,i)>-22.5 && p(j,i)<22.5)
            p_baixo = M(j,i+1);
            p_cima = M(j,i-1);
       
        
         elseif(p(j,i)>-67.5 && p(j,i)<-22.5)
            p_baixo = M(j-1,i+1);
            p_cima = M(j+1,i-1);
        
        
         elseif(p(j,i)>-112.5 && p(j,i)<-67.5)
            p_baixo = M(j-1,i);
            p_cima = M(j+1,i);
        
        
         elseif(p(j,i)>-157.5 && p(j,i)<-112.5)
            p_baixo = M(j+1,i+1);
            p_cima = M(j-1,i-1);
       
        
         elseif((p(j,i)>180 && p(j,i)>-157.5) || (p(j,i)>157.5 && p(j,i)<180))
            p_baixo = M(j,i-1);
            p_cima = M(j,i+1);
        
        
         elseif(p(j,i)>112.5 && p(j,i)<157.5)
            p_baixo = M(j+1,i-1);
            p_cima = M(j-1,i+1);
        
        
         elseif(p(j,i)>67.5 && p(j,i)<112.5)
            p_baixo = M(j+1,i);
            p_cima = M(j-1,i);
           
        
        else
            p_baixo = M(j-1,i-1);
             p_cima = M(j+1,i+1);
        end
        
        
        if(M(j,i)>p_cima && M(j,i)>p_baixo)
            Gn(j,i) = M(j,i);
         
        
        end
     end
end



Gnh = (Gn >= th);
Gnl = (Gn >= tl);
Gnl = Gnl - Gnh;


[M1,N,l] = size(Gnh);

for j = 2:M1-1
     for i = 2:N-1
         
         for u = j-1:j+1
             for v = j-1:j+1
                 
                 if(Gnl(u,v)==1) 
                  Gnl(u,v)=1;
               else
                  Gnl(u,v) = 0;
               end
                 
             end
         end
       
     end
end

Ib = Gnh + Gnl;

end








