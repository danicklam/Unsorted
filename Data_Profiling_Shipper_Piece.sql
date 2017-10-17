Sel --count (*)
top 100 ep.* , sp.*, ind.*
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party ep
inner join EDW_SCVER_CODA_ACCS_VIEWS.V_INDIVIDUAL Ind
on ind.party_id = ep.party_id
and ep.event_actual_dt = date '2017-01-04'
inner join EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
on EP.Piece_Id = SP.Piece_Id 
and ep.data_source_type_id = 11
and sp.source_system = 'PARCELS'
and sp.event_actual_date = date '2017-01-04'
;


create MULTISET volatile table swindon
as (select address_id
from EDW_SCVER_CODA_ACCS_VIEWS.V_dim_address da
where 1=1
and da.loc_posttown = 'SWINDON'
) 
WITH DATA
UNIQUE PRIMARY INDEX(address_id) 
ON COMMIT PRESERVE ROWS;


create MULTISET volatile table indivs
as (select PA.party_id
from EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pA, swindon da
where da.address_id = pa.address_id
) 
WITH DATA
UNIQUE PRIMARY INDEX(PARTY_ID) 
ON COMMIT PRESERVE ROWS;

COLLECT STATISTICS ON INDIVS COLUMN(PARTY_ID);

select 
top 100 ep.* , sp.*, ind.*
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party ep
inner join EDW_SCVER_CODA_ACCS_VIEWS.V_INDIVIDUAL Ind
on ind.party_id = ep.party_id
and ep.event_actual_dt = date '2017-01-04'
inner join EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
on EP.Piece_Id = SP.Piece_Id 
and ep.data_source_type_id = 11
and sp.source_system = 'PARCELS'
and sp.event_actual_date = date '2017-01-04'
inner join indivs i on ind.party_id = i.party_id
and ep.party_id = i.party_id


/*
AND EXISTS (
SEL pa.party_id from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pa
INNer jOIN 
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address da
ON pa.address_id = da.address_id
and da.LOC_PostTown = 'SWINDON'
where pa.party_id = ep.party_id
);
*/

SHOW TABLE EDW_SCVER.Shipper_Piece
;


Sel --count (*)
top 1000 * from EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
where sp.source_system = 'PARCELS'
and sp.event_actual_date = date '2017-01-04';

Sel --count (*)
 * from EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
where sp.source_system = 'PARCELS'
and sp.event_actual_date = date '2017-01-04'
sample 100;

sel top 100 *
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party
where data_source_type_id = 12
and event_actual_dt = date '2017-02-05';


sel data_source_type_id, count (*)
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party
where event_actual_dt between date '2017-02-01' and date '2017-02-07'
group by 1; 


sel data_source_type_id, count (*)
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party
where event_actual_dt between date '2017-01-21' and date '2017-01-30'
group by 1; 




SEL top 100
ep.* , sp.*, ind.*
from EDW_SCVER_CODA_ACCS_VIEWS.V_Event_Party ep
inner join EDW_SCVER_CODA_ACCS_VIEWS.V_INDIVIDUAL Ind
on ind.party_id = ep.party_id
and ep.event_actual_dt = date '2017-01-04'
inner join EDW_SCVER_CODA_ACCS_VIEWS.V_Shipper_Piece SP
on EP.Piece_Id = SP.Piece_Id 
and ep.data_source_type_id = 11
--and sp.source_system = 'PARCELS'
and sp.event_actual_date = date '2017-01-04'
;
 
