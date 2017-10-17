/* GET AN AREA OF ADDRESSES*/

sel * from
EDW_SCVER_CODA_DIM_VIEWS.v_dim_address
where
postcode like 'SE164%';

/*GET THE PARTIES USING A VOLATILE/TD LABS TABLE*/

CREATE TABLE   MgrS_LAM.SE_PARTY_ADDRESS AS (
sel vpa.* from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address vpa
Inner join
EDW_SCVER_CODA_DIM_VIEWS.v_dim_address vda
on vpa.address_id = vda.address_id
and vpa.address_type_id = 1
and vda.postcode like 'SE164%'

) with data
UNIQUE PRIMARY INDEX (party_id)
;

/*
sel count (*) from
MgrS_LAM.SE_PARTY_ADDRESS;
*/

COLLECT STATISTICS 
COLUMN(party_id) ON MgrS_LAM.SE_PARTY_ADDRESS
;

/*Output that data*/
sel * from
MgrS_LAM.SE_PARTY_ADDRESS
;


/*Get the individuals*/

CREATE TABLE   MgrS_LAM.SE_INDIVIDUAL AS (
sel vi.* from 
EDW_SCVER_CODA_ACCS_VIEWS.v_individual vi
INNER JOIN 
MgrS_LAM.SE_PARTY_ADDRESS  ttpa
on ttpa.party_id = vi.party_id
) with data
UNIQUE PRIMARY INDEX (party_id)
;

sel * from
MgrS_LAM.SE_INDIVIDUAL
;

/*Get some events*/
CREATE TABLE   MgrS_LAM.SE_EVENT_PARTY AS (
sel vep.* from
EDW_SCVER_CODA_ACCS_VIEWS.v_event_party vep
INNER JOIN
MgrS_LAM.SE_INDIVIDUAL tti
ON tti.party_id = vep.party_id
and vep.event_actual_dt between date'2017-02-01' and date'2017-02-10'
) with data
--UNIQUE PRIMARY INDEX (piece_id)
;

SEL count(*) FROM 
MgrS_LAM.SE_EVENT_PARTY
;

SEL * FROM 
MgrS_LAM.SE_EVENT_PARTY
;


/*Get the Mail Details*/
sel * from 
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece vmsp
INNER JOIN 
MgrS_LAM.SE_EVENT_PARTY ttep
on ttep.piece_id = vmsp.piece_id
and vmsp.tag_creation_date between date'2017-02-01' and date '2017-02-10'
;


