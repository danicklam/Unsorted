sel top 10 * from MGRS_LAM.CREDO_LIST_DATA;

sel count (*) 
--pa.party_id, da.address_id, ind.Name_prefix, ind.Forename, ind.lastname, da.*
from edw_scver_coda_dim_views.v_dim_address da
inner join edw_scver_coda_accs_views.v_party_address pa
on da.address_id = pa.address_id
and pa.address_type_id = 1
and da.postcode_area = 'LS'
inner join
edw_scver_coda_accs_views.v_individual ind
on ind.party_id = pa.party_id
inner join
MGRS_LAM.CREDO_LIST_DATA CLD
--on CLD.C1 = ind.Name_prefix  ---3042 matches including 4 parameters
on CLD.c2 = ind.Forename       ---5321 matches with just name and postcode
and CLD.c3 = ind.lastname
and CLD.C9 = da.postcode
;

sel count (*) from MGRS_LAM.CREDO_LIST_DATA; --18,950
sel top 10 * from MGRS_LAM.CREDO_LIST_DATA;

sel count (*) from MGRS_LAM.CREDO_LIST_DATA cld
inner join edw_scver_coda_dim_views.v_dim_address da
on cld.c9 = da.postcode         ----171,445
; --0 all postcode exists


sel count (*) from MGRS_LAM.CREDO_LIST_DATA cld
left join edw_scver_coda_dim_views.v_dim_address da
on cld.c9 = da.postcode
; -- 186,342




sel cld.* from MGRS_LAM.CREDO_LIST_DATA cld
left join edw_scver_coda_dim_views.v_dim_address da
on cld.c9 = da.postcode
minus
sel cld.* from MGRS_LAM.CREDO_LIST_DATA cld
inner join edw_scver_coda_dim_views.v_dim_address da
on cld.c9 = da.postcode
;


sel * from
edw_scver_coda_dim_views.v_dim_address dim
where postcode = 'LS209FG' -- need to remove spaces in the data set
and postcode_area = 'LS'
;