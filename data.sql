

create table mgrs_lam.LSP
 as 
 ( sel distinct da.address_id
from edw_scver_coda_accs_views.v_dim_address da
where da.postcode like 'LS%'
 ) with data;
 
 sel count (*) from
 mgrs_lam.LSP
 ;
 
 
 sel count (*) from
 mgrs_lam.LSPP;
 
create table mgrs_lam.LSPP
 as 
 ( sel distinct pa.party_id , da.address_id, pa.address_type_id
from edw_scver_coda_accs_views.v_party_address pa
inner join  mgrs_lam.LSP da
on pa.address_id = da.address_id
and pa.address_type_id = 1
 ) with data;
 
create table mgrs_lam.LSTE
 as 
(sel distinct pa.party_id , lspp.address_id, pa.address_type_id
from edw_scver_coda_accs_views.v_party_address pa
inner join  mgrs_lam.LSPP lspp
on pa.party_id = lspp.party_id
and pa.address_type_id IN (2,3)
 ) with data;
 
 sel count (*) from
 mgrs_lam.LSTE;
 
 help volatile table;

 
 drop table vt_LS;
  drop table vt_LSP;
 sel count (*) from
 vt_LSP;
 
 
 sel top 10* from 
 edw_scver_coda_accs_views.v_party_address;
  sel top 10* from 
 edw_scver_coda_accs_views.v_dim_address;