
% Written by Paul Ozkohen on 5-3-2018

% This function reads in two files containing coordinates for vertical and
% horizontal lines, then uses SVD and the orthogonality of vector property
% to compute the focal length, the direction vectors of the two sets of
% lines and the planar patch containing the rectangles.
function rectangle(file1, file2)
  % read horizontal and vertical line coordinates
  data_h = readfile(file1);
  data_v = readfile(file2);
  
  % minimum number of lines
  n = 3; 

  % amount of lines
  m_h = size(data_h,1);
  m_v = size(data_v,1);
  % at least 3 lines are required
  if (m_h < n || m_v < n || m_h ~= m_v); fprintf('M < 3 / error\n'); return; end
  
  % Compute focal length as described in 1.2 of our paper:
  % get both A matrices for vertical and horizontal lines
  A_h = form_A_matrix(data_h, m_h);
  A_v = form_A_matrix(data_v, m_v);
  [f, X_h, X_v] = compute_focal_length(A_h, A_v);
 
  % divide by f to find W vector
  W_h = [X_h(1) / f, X_h(2) / f, X_h(3)];
  W_v = [X_v(1) / f, X_v(2) / f, X_v(3)];

  W_h = W_h / norm(W_h,2);
  W_v = W_v / norm(W_v,2);
  
  fprintf('Camera constant: %d\n', f);
  fprintf('Direction vector for horizontal lines: [%f %f %f]\n',W_h );
  fprintf('Direction vector for vertical lines: [%f %f %f]\n',W_v );
  
% form the A matrix (without f)
function a=form_A_matrix(data, m)
  a = zeros(m,3);
  a(:,1) = data(:,4) - data(:,2);
  a(:,2) = -(data(:,3) - data(:,1));
  a(:,3) = data(:,2) .* -a(:,2)  - data(:,1) .* a(:,1);
        
% read the coordinates for the lines from a file
function data=readfile(file)
  f = fopen(file,'r');
  for i=1:4; fgets(f); end
  all = fscanf(f,'%f %f %f %f '); m = length(all)/4;
  data= reshape(all,4,m)';
  fclose(f);
 
        
