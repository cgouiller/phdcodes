function X = parseargs(X,varargin)
remaining = nargin -1;
count =1;
fields= fieldnames(X);
modified=zeros(size(fields));
while remaining >=2
    fieldname=varargin{count};
    fieldind=find(strcmp(fieldname,fields));
    if ~isempty(fieldind)
        oldvalue=getfield(X,fieldname);
        newvalue= varargin{count+1};
        if iscell(oldvalue)
            if ~iscellstr(oldvalue)
                error(sprintf('All allowed values for "%s" must be strings',fieldname));
            end
            if ~ischar(newvalue)
                error(sprintf('New value for "%s" must be strings', fieldname));
            end
            if isempty(find(strcmp(oldvalue,newvalue)))
                error(sprintf(' "%s" is not allowed for field "%s" ', newvalue,fieldname));
            end
        elseif ~isempty(oldvalue)
            if ~strcmp(class(oldvalue),class(newvalue))
                error(sprintf('Cannot change class of field "%s" from "%s" to "%s"',...
                    fieldname,class(oldvalue),class(newvalue)));
            elseif numel(oldvalue)==1 & numel(newvalue)~=1
                error(sprintf('New value for "%s" must be a scalar',fieldname));
            end
        end
        X=setfield(X,fieldname,newvalue);
        modified(fieldind)=1;
    else
        error(['Not a valid field name : ' fieldname]);
    end
    remaining=remaining-2;
    count=count+2;
end
if remaining ~=0
    error('Odd number of arguments supplied. Name=value pairs required');
end

notmodified = find(~modified);
for i=1:length(notmodified)
    fieldname=fields{notmodified(i)};
    oldvalue= getfield(X,fieldname);
    if iscell(oldvalue)
        if ~iscellstr(oldvalue)
            error(sprintf('All allowed values for "%s" must be strings',fieldname));
        elseif isempty(oldvalue)
            error(sprintf('Empty cell array not allowed for field "%s" ', fieldname));
        end
        X= setfield(X,fieldname,oldvalue{1});
    end
end