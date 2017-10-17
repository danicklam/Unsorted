create volatile table vt_Birmingham_parties as
(
sel pa.party_id, da.address_id, pa.address_type_id
from
edw_scver_coda_accs_views.v_party_address pa
inner join
edw_scver_coda_accs_views.v_dim_address da
on pa.address_id = da.address_id
and pa.address_type_id = 1
and da.postcode_area = 'B'
) with data
on commit preserve rows
;

sel pa.party_id, vt.address_id, pa.address_type_id
from vt_birmingham_parties vt
inner join
edw_Scver_coda_accs_views.v_party_address  pa
on vt.party_id = pa.party_id
and pa.party_type_id = 2
-- and pa.party_type_id = 3
;

sel * from 
edw_scver_coda_accs_views.v_address_type
;

sel top 100 * from
edw_scver_coda_accs_views.v_dim_address 
;