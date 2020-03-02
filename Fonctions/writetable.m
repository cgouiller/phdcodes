function writetable(a,filename,varargin)
if nargin<2 
    tablename=inputname(1);
    if isempty(tablename)
        tablename='table';
    end
    filename=[tablename '.txt'];
end
writeTextFile(a,filename,varargin{:});
