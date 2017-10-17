database EDW_SCVER_CODA_ACCS_VIEWS;


select * from EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in;



create volatile table vtresults as 
(
select
distinct
tods.sk_id,
match.addr_postcode, tods.postcode from 
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results match, 
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in tods
where cast (match.SK_DQ_Input as integer) = tods.SK_Id
and tods.DQ_Batch_Id=27572
and match.dq_batch_id = 27572
) with data
;


create multiset table mgrs_lam.compare as (
select distinct
tods.sk_id as ID, 'TODS_IN' as DSOURCE, tods.postcode as PC
from EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in tods
where tods.DQ_Batch_Id=30701
UNION
select distinct
match.sk_dq_input as ID, 'MATCH_OUT' as DSOURCE,
match.addr_postcode as PC  from 
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results match
where match.DQ_Batch_Id=30701
) with data
;

insert into mgrs_lam.compare
select distinct
tods.sk_id as ID, 'TODS_IN' as DSOURCE, tods.postcode as PC
from EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in tods
where tods.DQ_Batch_Id IN (30828, 30735, 30734,30671,30643)
UNION
select distinct
match.sk_dq_input as ID, 'MATCH_OUT' as DSOURCE,
match.addr_postcode as PC  from 
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results match
where match.DQ_Batch_Id IN (30828, 30735, 30734,30671,30643)
;
sel dsource, count (*)
from
mgrs_lam.compare
group by 1
;

select * from edw_scver_coda_accs_views.v_cc_batch_queue
where scv_data_source = 'TODS'
and cc_process_flag = 8;



sel top 10 * from 
mgrs_lam.compare;

sel Dsource, count (*) 
from mgrs_lam.compare
group by 1;

---MATCH_O,654921
---TODS_IN,651880

sel * from
mgrs_lam.compare comp
inner join 
(sel ID, count (distinct PC) as PC
from mgrs_lam.compare
group by 1
having count (distinct PC) > 1) x
on comp.ID = x.ID
;


sel count(*), count (distinct ID) from
(
sel * from
mgrs_lam.compare
where ID
IN (sel ID
from mgrs_lam.compare
group by 1
having count(*)>1)
)x

;


sel count(*), count (distinct ID) from
(
sel * from
mgrs_lam.compare
where ID
IN (sel ID
from mgrs_lam.compare
group by 1
having count(*)>1)
)x

;  ---- 1303760,651880
/*
drop table mgrs_lam.todsinout;
*/

create multiset table mgrs_lam.todsinout  as (
sel distinct 
c1.ID, 
c1.dsource as INPUT_D, c1.PC as IN_PC,
c2.dsource as OUTPUT_D, c2.PC as OUT_PC
from mgrs_lam.compare c1
inner join mgrs_lam.compare c2
on c1.ID = c2.ID
and c1.DSOURCE = 'TODS_IN'
and c2.DSOURCE = 'MATCH_O'
) with data
;
sel count (*) from
mgrs_lam.todsinout
;
sel count (*) from
mgrs_lam.todsinout
where IN_PC <> OUT_PC
;
sel count (*) from
mgrs_lam.todsinout
where oreplace(IN_PC,' ','') <> oreplace(OUT_PC,' ','')
;








sel count (distinct ID) from
 mgrs_lam.compare;
--- 654921

 
 
sel ID, count (distinct PC)
from mgrs_lam.compare
group by 1
having count (distinct PC) > 1
;

COLLECT STATISTICS on mgrs_lam.compare INDEX (ID);
---33,038


sel distinct x.id, match.addr_postcode  from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results match
inner join 
(sel distinct ID from mgrs_lam.compare)x
on  match.SK_DQ_Input = x.id 
;



sel top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results;


sel top 10* from
EDW_SCVER_CODA_ACCS_VIEWS.v_shipper_piece
where source_system = 'TODS'
;

create table MGRS_LAM.tod_events as
(
sel event_id, party_id, piece_id, event_actual_dt
--count (*), count (distinct piece_id) 
from EDW_SCVER_CODA_ACCS_VIEWS.v_event_party
where data_source_type_id = 2
and piece_id <>0
and event_actual_dt between date '2017-06-01' and date '2017-06-07'
) with data;


sel top 100 * from
MGRS_LAM.tod_events ;

create table MGRS_LAM.tod_compare as (
sel tods.* , vpa.address_id, vda.postcode from
MGRS_LAM.tod_events tods
inner join edw_scver_coda_accs_views.v_party_address vpa
on vpa.party_id = tods.party_id
and vpa.address_type_id = 1
inner join edw_scver_coda_accs_views.v_dim_address vda
on vda.address_id = vpa.address_id
) with data
;

sel * from
MGRS_LAM.tod_compare
;

sel count (*) from (
sel * from
MGRS_LAM.tod_compare
where
(piece_id) IN 
(sel piece_id from 
MGRS_LAM.tod_compare
group by 1 
having count (*) > 1)
--order by piece_id
)x
;


sel count(*), count (distinct piece_id)
from MGRS_LAM.tod_compare;

sel count (*) from (
sel * from
MGRS_LAM.tod_compare
where
(piece_id, postcode) IN 
(sel piece_id, postcode from 
MGRS_LAM.tod_compare
group by 1 ,2
having count (*) > 1)
--order by piece_id
)x
;

sel count (*) from (
sel * from
MGRS_LAM.tod_compare
where
(piece_id,address_id, postcode) IN 
(sel piece_id, address_id, postcode from 
MGRS_LAM.tod_compare
group by 1 ,2,3
having count (*) > 1)
--order by piece_id
)x
;

