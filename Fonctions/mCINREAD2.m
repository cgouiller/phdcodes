function [film_tmp,black_ref,params]=mCINREAD2(file,varargin)

fid=fopen(file,'r','l');
params=struct('resx',0,'resy',0,'total_nframes',0,'Postrig',0,'fps',0,'exptime',0,'EDR',0,'Bpp',0,'BkRefInd',0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read Cine File header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params.resx=fopen(fid,1,'int');
params.resy=fopen(fid,1,'int');
params.total_nframes=fopen(fid,1,'int');
params.fps=fopen(fid,1,'float');
params.Postrig=fopen(fid,1,'int');
params.exptime=fopen(fid,1,'int');
params.EDR=fopen(fid,1,'int');
params.Bpp=fopen(fid,1,'int');
params.BkRefInd=fopen(fid,1,'int');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read Images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin>1
    nstart=varargin{1};
    nframes=varargin{2};
else
    nstart=1;
    nframes=params.total_nframes;
end

% film_tmp=zeros(params.resx,params.resy,nframes);
% black_ref=zeros(params.resx,params.resy);
%% weird blackreferencing
if params.Bpp==0
	pixels=fopen(fid,params.resx*params.resy,'uint8=>uint8');
else
	pixels=fopen(fid,params.resx*params.resy,'uint16=>uint16');
end
black_ref=reshape(pixels,params.resx,params.resy);
black_ref=permute(black_ref,[2 1]);
% weird
%% here is the image section 
fseek(fid,params.resx*params.resy*(nstart-1)*(params.Bpp+1),0);

if params.Bpp==0
	film_tmp=(fopen(fid,params.resx*params.resy*nframes,'uint8=>uint8'));
else
	%for kk=1:nframes
	film_tmp=(fopen(fid,params.resx*params.resy*nframes,'uint16=>uint16'));
	%end
end
	
film_tmp=reshape(film_tmp,params.resx,params.resy,nframes);
film_tmp=permute(film_tmp,[2 1 3]);

fclose(fid);

%film_tmp=reshape(resx,resy,nframes);
%film_tmp=uint8(zeros(resx,resy,1,nframes));
%for p=1:nframes+1
%	pixels=fopen(fid,[resx,resy],'uint8');
%    film_tmp(:,:,1,p)=flipud(pixels');
%    %[film(:,:,:,p),map]=gray2ind(pixels,2^biBitCount);   
%    %[film,map]=gray2ind(pixels,2^biBitCount);
%end
   %map=colormap(gray(2^(biBitCount-4)));
   %film=immovie(film_tmp,map);