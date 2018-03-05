% this function computes the focal length, utilizing the orthogonality
% of the vertical and horizontal lines and the SVD routine on both A
% matrices
function [ f, X_h, X_v ] = compute_focal_length( A_h, A_v )

  % call matlab SVD routine to compute X vectors for horizontal and
  % vertical lines
  [U,S,V] = svd(A_h);  
  X_h = V(:,3);
  if all(X_h < 0); X_h = -X_h; end 
  
  [U,S,V] = svd(A_v);  
  X_v = V(:,3);
  if all(X_v < 0); X_v = -X_v; end 
  
  % compute focal length f using both X vectors, utilizing equation
  % 22 from our paper
  f = sqrt((-(X_h(1) * X_v(1)) -(X_h(2) * X_v(2))) / (X_h(3) * X_v(3)));
  
  


end

