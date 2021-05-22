function part=track2part(vtracks,varargin)

if nargin<2
    
    %N=arrayfun(@(X)(numel(X.Tf)),vtracks);
    %N=arrayfun(@(X)(numel(X.frame)),vtracks);
    N=arrayfun(@(X)(numel(X.Tf)),vtracks);
    T=[vtracks.Tf];
    %T=vertcat(vtracks.frame);
    %[T,I]=sort(T);
    
    %X=[vtracks.X];
    %X=X(I);
    
    %Y=[vtracks.Y];
    %Y=Y(I);
    if isrow(vtracks(1).Xf)
        X=[vtracks.Xf];
    else
        X=vertcat(vtracks.Xf);
    end
    %Xf=Xf(I);
    %X=[vtracks.x];
    %X=vertcat(vtracks.x);
    
    if isrow(vtracks(1).Yf)
        Y=[vtracks.Yf];
    else
        Y=vertcat(vtracks.Yf);
    end
    %Yf=Yf(I);
    %Y=[vtracks.y];
    %Y=vertcat(vtracks.y);
    
    %Theta=[vtracks.Yf];
    
    %Rho=[vtracks.Rhof];
    
    if isrow(vtracks(1).Vx)
        Vx=[vtracks.Vx];
    else
        Vx=vertcat(vtracks.Vx);
    end
    %Vx=Vx(I);
    
    if isrow(vtracks(1).Vy)
        Vy=[vtracks.Vy];
    else
        Vy=vertcat(vtracks.Vy);
    end
    %Vy=Vy(I);
    
    if isrow(vtracks(1).Ax)
        Ax=[vtracks.Ax];
    else
        Ax=vertcat(vtracks.Ax);
    end
    %Ay=Ay(I);
    
    if isrow(vtracks(1).Ay)
        Ay=[vtracks.Ay];
    else
        Ay=vertcat(vtracks.Ay);
    end
    %Ax=Ax(I);
    
    Ntrack=X*0;
    
    NN=1;
    for k=1:numel(vtracks)
        Ntrack(NN:NN+N(k)-1)=k;
        NN=NN+N(k);
    end
    %Ntrack=Ntrack(I);
    binT=unique(T);
    
    for k=1:numel(binT)
        I=find(T==binT(k));
        part(k).T=binT(k);
        %   part(k).X=X(I);
        %   part(k).Y=Y(I);
        part(k).X=X(I);
        part(k).Y=Y(I);
        %   part(k).Theta=Theta(I);
        %   part(k).Rho=Rho(I);
        part(k).Vx=Vx(I);
        part(k).Vy=Vy(I);
        part(k).Ax=Ax(I);
        part(k).Ay=Ay(I);
        part(k).Ntrack=Ntrack(I);
    end
else
    fields = varargin{1};
    Tfield = fields{varargin{2}};
    
    N=arrayfun(@(X)(numel(X.(Tfield))),vtracks);
    
    
    if isrow(vtracks(1).(Tfield))
        T=[vtracks.(Tfield)];
    else
        T=vertcat(vtracks.(Tfield));
    end
    
    binT=unique(T);
    
    NN=1;
    for k=1:numel(vtracks)
        Ntrack(NN:NN+N(k)-1)=k;
        NN=NN+N(k);
    end
    
    for k=1:numel(binT)
        part(k).T=binT(k);
        I=find(T==binT(k));
        part(k).Ntrack=Ntrack(I);
        
        for kfield=1:numel(fields)
            if isrow(vtracks(1).(fields{kfield}))
                X=[vtracks.(fields{kfield})];
            else
                X=vertcat(vtracks.(fields{kfield}));
            end
            part(k).(fields{kfield})=X(I);
        end
    end
end