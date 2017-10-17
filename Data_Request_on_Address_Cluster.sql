sel count (*)(float) from 
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address
where address_type_id = 1;


CREATE TABLE MgrS_LAM.DAPA
AS (
SEL 
pa.party_id,
da.address_id ,
da.Thfare_Id,  da.Locality_ID 
from
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address da
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pa
ON pa.address_id = da.address_id
and pa.address_type_id = 1
and da.postcode like  'SN%'
)
WITH DATA
PRIMARY INDEX (party_id)
;

INSERT INTO
MgrS_LAM.DAPA
SEL
pa.party_id,
da.address_id ,
da.Thfare_Id,  da.Locality_ID 
from
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address da
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pa
ON pa.address_id = da.address_id
and pa.address_type_id = 1
and da.postcode like  'LS%'
;

sel count (*) from MgrS_LAM.DAPA;

/*
and da.postcode like  'B2%'
and da.postcode like  'B3%'
and da.postcode like  'B4%'
and da.postcode like  'B5%'
and da.postcode like  'B6%'
and da.postcode like  'B7%'
and da.postcode like  'B8%'
and da.postcode like  'B9%'
and da.postcode like 'LS%''
*/

sel count (*) from MgrS_LAM.DAPA;


sel party_id, count (*)
from
MgrS_LAM.DAPA
group by 1
order by 2 desc;

sel top 100 * from
MgrS_LAM.DAPA
;

select 1, i.party_id, psd.address_id ,
da.Thfare_Id,  da.Locality_ID, i.Name_Prefix, i.Forename, i.Lastname, i.Name_Suffix, i.Gender_Ind,
CURRENT_DATE AS SCVER_LOAD_DTTM, 
CURRENT_DATE AS SCVER_UPD_DTTM, 
3 AS ETL_MODULE_RUN_ID,

PSD.address_id as address_grpng_key
from EDW_SCVER_CODA_ACCS_VIEWS.v_PARTY_SOURCE_DTL psd
, EDW_SCVER_CODA_ACCS_VIEWS.v_individual i
, EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address da
, MgrS_LAM.SN_SELECTION mgr
where psd.party_id = i.party_id
and psd.address_id = da.address_id
and mgr.party_id = psd.party_id
and psd.address_type_id=1
and psd.data_source_cd <> 'MEARS_ADF'
;

ALter table
MgrS_LAM.DAPA
ADD NewCol char(1) DEFAULT '1' NOT NULL;

CREATE SET TABLE MgrS_LAM.DAPA ,NO FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO
     (
      Party_Id DECIMAL(18,0),
      Address_Id INTEGER,
      Thfare_Id INTEGER,
      Locality_ID INTEGER,
      NewCol BYTEINT )
PRIMARY INDEX ( Party_Id ,Address_Id ,NewCol );

del MgrS_LAM.DAPA;
insert into MgrS_LAM.DAPA
sel * from MgrS_LAM.DAPA2

CREATE TABLE MgrS_LAM.DAPA2
AS (
SEL 
* FROM
MgrS_LAM.DAPA
)
WITH DATA
PRIMARY INDEX (party_id,  address_id , NewCol)
;

sel count (*) from
MgrS_LAM.DAPA2;

drop table
MgrS_LAM.DAPA;


sel dp.party_id, dp.address_id, dp.NewCol, psd.*
from
MgrS_LAM.DAPA dp
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_PARTY_SOURCE_DTL psd
ON
psd.party_id = dp.Party_id
AND psd.address_id = dp.address_id
AND psd.address_type_id = dp.NewCol
;




sel data_source_cd, count (*) (float) from
EDW_SCVER_CODA_ACCS_VIEWS.v_PARTY_SOURCE_DTL
where data_source_cd <> 'MEARS_ADF'
group by 1
;

sel top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_PARTY_SOURCE_DTL
;


create table MgrS_LAM.PSDAPA as (
select
--1,
mgr.party_id, psd.address_id ,
mgr.Thfare_Id,  mgr.Locality_ID,
---i.Name_Prefix, i.Forename, i.Lastname, i.Name_Suffix, i.Gender_Ind,
CURRENT_DATE AS SCVER_LOAD_DTTM, 
CURRENT_DATE AS SCVER_UPD_DTTM, 
psd.data_source_cd,
3 AS ETL_MODULE_RUN_ID,
PSD.address_id as address_grpng_key
from EDW_SCVER_CODA_ACCS_VIEWS.v_PARTY_SOURCE_DTL psd
--, EDW_SCVER_CODA_ACCS_VIEWS.v_individual i
, MgrS_LAM.DAPA mgr
where psd.party_id = mgr.party_id
and psd.address_id = mgr.address_id
and psd.address_type_id= mgr.NewCol
and psd.address_type_id = 1
) with data
primary index (party_id)
;

select 1, i.party_id, psd.address_id ,
psd.Thfare_Id,  psd.Locality_ID, i.Name_Prefix, i.Forename, i.Lastname, i.Name_Suffix, i.Gender_Ind,
CURRENT_DATE AS SCVER_LOAD_DTTM, 
CURRENT_DATE AS SCVER_UPD_DTTM, 
3 AS ETL_MODULE_RUN_ID,
CASE psd.data_source_cd
WHEN 'CREDO' THEN 215 
WHEN 'CREDO_IND' THEN 215
WHEN 'CREDO_ORG' THEN 215
WHEN 'TODS' THEN 120
WHEN 'MARS_ORG' THEN 190
WHEN 'SIEBEL' THEN 140
WHEN 'MARS' THEN 190
WHEN 'POISE' THEN 125
WHEN 'MARS_IND' THEN 190
WHEN 'MEARS_ADF' THEN 070
WHEN 'PARCELS' THEN 130
WHEN 'SPS' THEN 150
WHEN 'RMGTT' THEN 020
WHEN 'KOGNITIO' THEN 210
WHEN 'MEARS_ADF' THEN 070
ELSE 10
END AS BEST_SRC_ID,
PSD.address_id as address_grpng_key
from MgrS_LAM.PSDAPA psd
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_individual i
ON psd.party_id = i.party_id
where psd.party_id MOD 10 = 0
;

sel distinct data_source_cd
from 
MgrS_LAM.PSDAPA;


sel count (*) from MgrS_LAM.PSDAPA;

create table MrrS_LAM.