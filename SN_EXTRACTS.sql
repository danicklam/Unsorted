create volatile table vt_address as
(
sel distinct address_id from
edw_scver_coda_accs_views.v_dim_address
where substr( Postcode, 1 ,2) = 'SN'
) with data
on commit preserve rows;

sel count (*) from vt_address;

create multiset table MgrS_lam.SN_PARTY_ADDRESS_IDS as
(
sel distinct pa.party_id, pa.address_id, pa.address_type_id
from 
vt_address vt
inner join
edw_scver_coda_accs_views.v_party_address pa
on vt.address_id = pa.address_id
and pa.address_type_id = 1
) with data
;

sel count (*) from MgrS_lam.SN_PARTY_ADDRESS_IDS;

sel * from 
MgrS_lam.SN_PARTY_ADDRESS_IDS
where  party_id mod 3 = 0 
;
sel * from 
MgrS_lam.SN_PARTY_ADDRESS_IDS
where  party_id mod 3 = 1 
;
sel * from 
MgrS_lam.SN_PARTY_ADDRESS_IDS
where  party_id mod 3 = 2 
;

sel p1.party_id, p2.address_id, p2.address_type_id
from  MgrS_lam.SN_PARTY_ADDRESS_IDS   p1
inner join  edw_scver_coda_accs_views.v_party_address   p2
on p1.party_id = p2.party_id
and p2.address_type_id  = 2 ;

sel p1.party_id, p2.address_id, p2.address_type_id
from  MgrS_lam.SN_PARTY_ADDRESS_IDS   p1
inner join  edw_scver_coda_accs_views.v_party_address   p2
on p1.party_id = p2.party_id
and p2.address_type_id  = 3 ;

