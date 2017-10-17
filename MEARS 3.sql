sel top 100 
ep.party_id, ep.event_actual_dt, pa.address_id, ep.data_source_type_id, 
count (distinct piece_id), count (distinct event_id), count (tag_id) 
from edw_scver_coda_accs_views.v_event_party ep
inner join edw_scver_coda_accs_views.v_party_address pa
on ep.party_id = pa.party_id
and pa.address_type_id = 1
and ep.event_actual_dt between date '2017-03-01' and date '2017-03-04'
group by 1,2,3,4;



