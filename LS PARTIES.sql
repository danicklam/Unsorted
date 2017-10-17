sel * from
mgrs_lam.LSTE;

--sel count (*) 
sel *
from
mgrs_lam.LSPP
where party_id mod 3  = 0;

--sel count (*)
sel * 
from
mgrs_lam.LSPP
where party_id mod 3  = 1;

--sel Count(*)
sel * 
from
mgrs_lam.LSPP
where party_id mod 3  = 2;

sel count (*) 
--sel *
from
mgrs_lam.LSPP;