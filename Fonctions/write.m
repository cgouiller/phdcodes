function write(t,filename,varargin)

try
    if nargin<2 || isempty(filename)
        type='text';
        tablename=inputname(1);
        if isempty(tablename)
            tablename='table';
        end
        filename=[tablename '.txt'];
        otherArgs={'WriteVariableNames',true,'WriteRowNames',false'};
    else
        pnames={'FileType'};
        dflts={[]};
        [type,supplied,otherArgs]=parseargs(pnames,dflts,varargin{:});
        [~,~,fx] = fileparts(filename);
        if ~supplied.FileType
            if isempty(fx)
                fx='.txt';
                filename=[filename fx];
            end
            switch fx
                case {'.txt''.dat''.csv'},type='text';
                case {'.xls''.xlsx''.xlsb''.xlsm'},type='spreadsheet';
                otherwise
                    error(message('MATLAB:table:write:UnrecognizedFileExtension',fx));
            end
        else
            fileTypes={'text' 'spreadsheet'};
            itype=find(strncmpi(type,fileTypes,length(type)));
            if isempty(itype)
                error(message('MATLAB:table:write:UnrecognizedFileType',type));
            elseif~isscalar(itype)
                error(message('MATLAB:table:write:AmbiguousFileType',type));
            end
            
            %Add default extension if necessary
            if isempty(fx)
                dfltFileExts={'.txt''.xls'};
                filename=[filename dfltFileExts{itype}];
            end
        end
    end
    
    switch lower(type)
        case 'text'
            writeTextFile(t,filename,otherArgs);
        case 'spreadsheet'
            try
                Excel=actxserver('Excel.Application');
            catch me
                error(message('MATLAB:table:write:NoCOMServer'));
            end
            Excel.Quit;
            
            writeXLSFile(t,filename,otherArgs);
        otherwise
            error(message('MATLAB:table:write:UnrecognizedFileType',type));
    end
catch ME
    throwAsCaller(ME)
end







        
        