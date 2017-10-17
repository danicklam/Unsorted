

sel top 10* from
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_address_access; /*1*/
sel top 10* from
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_customer;       /*2*/
sel top 10* from
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_contract;       /*3*/
sel top 10* from
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_track_data;     /*4*/
sel top 10* from
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_link;           /*5*/
sel top 10* from 
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_preadvice;      /*6*/
sel top 10* from edw_scver_coda_accs_views.v_event_party
where data_source_type_id = 2;

sel * from 
EDW_SCVER_CODA_ACCS_VIEWS.v_data_source_type;


sel distinct postal_event_type_id
from edw_scver_coda_accs_views.v_event_party
where data_source_type_id = 2
and event_actual_dt = '2017-06-01';


sel count (*), count (distinct piece_id)
from edw_scver_coda_accs_views.v_event_party
where data_source_type_id = 2
and event_actual_dt = '2017-06-01';

sel count (*) from ( 
sel piece_id, count (distinct party_id) as countparty
from edw_scver_coda_accs_views.v_event_party
where data_source_type_id = 2
and event_actual_dt = '2017-06-01'

group by 1
having count (distinct party_id) > 1) x;
-----148,451


sel count (*)
from edw_scver_coda_accs_views.v_event_party
where data_source_type_id = 2
and event_actual_dt = '2017-06-01';

----933,378


sel * 
from edw_scver_coda_accs_views.v_event_party
where data_source_type_id = 2
and event_actual_dt = '2017-06-01'
and piece_id = 2374424378;


sel * from edw_scver_coda_accs_views.v_party_address 
where party_id IN (3212213394,3212213405)
and address_type_id  = 1; 








sel count (distinct src_consignment_no), count (distinct src_consignment_id), count (*) from
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_preadvice;
--- 6,061,898 __ 5,875,275 __ 6,390,597

sel count (distinct track_unit_no), count (*) from
EDW_SCVER_CODA_STG_VIEWS.v_stg_poise_track_data;
---8,856,128 ___ 57,822,338

--sel top 10* from
--EDW_SCVER_CODA_ACCS_VIEWS.v_exception_reason;
--sel top 10* from
--EDW_SCVER_CODA_ACCS_VIEWS.v_postal_exception;
sel top 10* from
EDW_SCVER_CODA_ACCS_VIEWS.v_SHIPPER_PIECE;
sel top 10* from
EDW_SCVER_CODA_ACCS_VIEWS.v_sales_transaction;
sel top 10* from
EDW_SCVER_CODA_ACCS_VIEWS.v_sales_transaction_line;
sel top 10* from
EDW_SCVER_CODA_ACCS_VIEWS.v_delivery;

sel distinct rm_event_code from
EDW_SCVER_CODA_ACCS_VIEWS.v_delivery;


sel count(*), count (distinct sales_tran_id), count (sales_tran_line_id) from
EDW_SCVER_CODA_ACCS_VIEWS.v_sales_transaction_line;


sel top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in;

sel top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results;



sel count(*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in  tods
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results results
on tods.SK_ID = results.SK_DQ_output
and results.dq_batch_id = 21513
and tods.dq_batch_id = 21513
;

create volatile table vt_batches_in as (
sel distinct (tods.dq_batch_id) from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in tods) with data;

create volatile table vt_batches_out as (
sel distinct (dq_batch_id) from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results results
) with data;


create volatile table vt_batches_match as (
sel distinct (vtin.dq_batch_id) from
vt_batches_in vtin inner join vt_batches_out vtout
on vtin.dq_batch_id = vtout.dq_batch_id
) with data;


sel * from 
edw_scver_coda_accs_views.v_cc_batch_queue
where cc_process_flag = 8
and scv_data_source = 'TODS';


sel count (*), count (distinct sk_dq_output), count (distinct sk_dq_input)
--distinct SK_DQ_OUTPUT, SK_DQ_INPUT, ADDR_ADDRESS_ID, ADDR_POSTCODE
from EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results
where dq_batch_id = 30734
;
--------------- 556838,556838,549988


create volatile table vt_matches
as
(sel
SK_DQ_OUTPUT, SK_DQ_INPUT, ADDR_ADDRESS_ID, ADDR_POSTCODE
from EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results
where dq_batch_id = 30735
group by 1,2,3,4
)with data;




sel count (*) from vt_matches;
drop table vt_matches;





sel count (*) from
vt_batches_match
;

--inner join EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results results
--on tods.dq_batch_id = results.dq_batch_id;


sel count(*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_tods_in  tods;
sel count(*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results results;




sel top 10 * from 
EDW_SCVER_CODA_ACCS_VIEWS.v_base_mpe;





