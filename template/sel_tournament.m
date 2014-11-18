function NewChrIx = sel_tournament(FitnV,Nsel)
    Nind=size(FitnV,1);
    tournamentSize=round(Nind/10);

    for i=1:Nsel
        rndperm=randperm(Nind);
        tournament=rndperm(1:tournamentSize);
        [~, pos]=max(FitnV(tournament))
        NewChrIx(i)=tournament(pos);
    end
end

