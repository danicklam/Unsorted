sel party_start_dttm, count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_kog_xref
where party_start_dttm > date '2017-03-01'
group by 1
;

sel party_start_dttm, count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_kog_xref
where party_start_dttm > date '2017-03-01'
group by 1
;

sel count (*) from 
EDW_SCVER_CODA_ACCS_VIEWS.v_party_kog_xref;


 sel data_source_type_id, event_actual_date , count (*), count (distinct piece_id), 
 count (distinct event_id), count (distinct mears_tag_id) , count (distinct etl_module_run_id)
 from edw_scver_coda_dim_views.v_fct_piece_event
 where event_actual_date >= date '2017-02-01'
 and event_actual_date < date '2017-03-01'
 group by 1, 2
 
 ;
 
 
 
 
 sel xref.* , dad.*
 from
  EDW_SCVER_CODA_ACCS_VIEWS.v_party_kog_xref xref
  inner join
 EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pad
 ON xref.party_id = pad.party_id
 inner join 
  EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address dad
  on dad.address_id = pad.address_id
  and dad.postcode like 'SN5%'
 ;
 
 
 
 