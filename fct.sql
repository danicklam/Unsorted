 sel data_source_type_id, event_actual_date , count (*), count (distinct piece_id), count (distinct event_id), count (distinct mears_tag_id) from 
 edw_scver_coda_dim_views.v_fct_piece_event
 where event_actual_date <= date '2017-01-01'
 group by 1, 2
 
 Union 
  sel data_source_type_id, event_actual_date , count (*),count (distinct piece_id), count (distinct event_id), count (distinct mears_tag_id) from 
 edw_scver_coda_dim_views.v_fct_piece_event
 where event_actual_date > date '2017-01-01'
 and event_actual_date < date '2017-02-01'
 group by 1, 2
 
  Union 
  sel data_source_type_id, event_actual_date , count (*), count (distinct piece_id), count (distinct event_id), count (distinct mears_tag_id) from 
 edw_scver_coda_dim_views.v_fct_piece_event
 where event_actual_date >= date '2017-02-01'
 and event_actual_date < date '2017-03-01'
 group by 1, 2
 
 ;
 
 
 sel data_source_type_id, event_actual_date , count (*), count (distinct piece_id), count (distinct event_id), count (distinct mears_tag_id) from 
 edw_scver_coda_dim_views.v_fct_piece_event
 where event_actual_date >= date '2017-03-01'

 group by 1, 2 ;
 
 
 
 
 
 sel * from 