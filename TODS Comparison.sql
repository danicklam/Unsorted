
/*Create table of batches of input and output data*/

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

sel top 10 * from EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in tods;
sel top 10 * from EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results;

/*INCREASING SAMPLE SIZE*/

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

/*Create comparison table */

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

/*COUNTS OF FIGURES*/
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


sel * from
mgrs_lam.todsinout
where oreplace(IN_PC,' ','') <> oreplace(OUT_PC,' ','')
;


sel top 1999 * from
mgrs_lam.todsinout
;



/*Checking input matches*/

create multiset table mgrs_lam.todsinput  as (
sel distinct 
c1.ID, 
c1.dsource as INPUT_1, c1.PC as IN_PC,
c2.dsource as INPUT_2, c2.PC as OUT_PC
from mgrs_lam.compare c1
inner join mgrs_lam.compare c2
on c1.ID = c2.ID
and c1.DSOURCE = 'TODS_IN'
and c2.DSOURCE = 'TODS_IN'
) with data
;

sel count (*) from mgrs_lam.todsinput ;
sel count (*) from
mgrs_lam.todsinput
where IN_PC <> OUT_PC
;
sel count (*) from
mgrs_lam.todsinput
where oreplace(IN_PC,' ','') <> oreplace(OUT_PC,' ','')
;


sel * from
mgrs_lam.todsinput
where IN_PC <> OUT_PC
;



/*TODS PREP INPUT*/

create table mgrs_lam.todsprep as (
sel SK_ID, del_scan_date, dq_batch_id, piece_id, postcode from
EDW_SCVER_CODA_ACCS_VIEWS.v_prep_tods_scv
where dq_batch_id IN (30828, 30735, 30734,30671,30643,30701)
) with data ;

collect stats on mgrs_lam.todsprep 
column (piece_id);

sel count (*) from mgrs_lam.todsprepresults;
drop table mgrs_lam.todsprepresults;
create multiset table mgrs_lam.todsprepresults as (
sel distinct t1.SK_ID,  t2.SK_ID,
t1.del_scan_date as date1, t1.dq_batch_id as batch1, t1.piece_id as piece1, t1.postcode as PC1,
t2.del_scan_date as date2, t2.dq_batch_id as batch2, t2.piece_id as piece2, t2.postcode as PC2
FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_prep_tods_scv t1
inner join 
EDW_SCVER_CODA_ACCS_VIEWS.v_prep_tods_scv t2
on t1.piece_id = t2.piece_id
and t1.sk_id<> t2.sk_id
) with data ;

sel count (*) from mgrs_lam.todsprepresults;
sel count (*) from mgrs_lam.todsprepresults where PC1 <> PC2;
sel count (*) from mgrs_lam.todsprepresults where oreplace(PC1,' ','') <> oreplace(PC2,' ','');
sel * from mgrs_lam.todsprepresults where PC1 <> PC2;

sel top 100 * from mgrs_lam.todsprepresults ;
