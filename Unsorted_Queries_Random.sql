 
sel top 100 * from 
EDW_SCVER_CODA_ACCS_VIEWS.v_agreement
;

sel recorded_appl_dt , count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_agreement
group by 1
order by recorded_appl_dt desc
;

sel received_appl_dt , count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_agreement
group by 1
order by received_appl_dt desc
;

sel top 100 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_agmt_term
;


sel * from 

edw_scver_coda_accs_views.v_cc_batch_queue
where scv_data_source like '%CREDO%'
order by dq_batch_id desc;





sel top 100 * from
edw_scver_coda_accs_views.v_base_mpe;


sel count (*) from
edw_scver_coda_accs_views.v_base_mpe
where scanlocation_Longitude > -1.9494
and scanlocation_Longitude < -1.6219
and scanlocation_latitude > 51.4953
and scanlocation_latitude < 51.6282
and event_dttm like '2017-03-30%'
;
