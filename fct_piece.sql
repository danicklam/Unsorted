 sel event_actual_date , data_source_type_id, count (*)
 from edw_scver_coda_dim_views.v_fct_piece_event
 where event_actual_date > date '2017-05-01'
 group by 1, 2
 ;
 
 sel *  from edw_scver_coda_dim_views.v_fct_piece_event
 where event_actual_date = date'2017-08-01'
 ;
 
 
 sel top 10 * from edw_scver_coda_accs_views.v_eib_supply_chain;