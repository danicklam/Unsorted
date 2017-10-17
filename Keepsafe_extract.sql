sel top 10 * from 
edw_scver_coda_accs_views.v_agreement;

sel top 10 * from 
edw_scver_coda_dim_views.v_dim_address;




sel requested_by, requestor_email, email_opt_out_ind, hsptlzn_cd, address_id, PREM_SubBuilding_Name, 
PREM_BuildingName, PREM_BuildingNumber, PREM_POBox, THO_DepThoroughfare, THO_Thoroughfare, LOC_DepLocality, 
LOC_Locality, LOC_PostTown, postcode, 
count(distinct src_agreement_num) as Agreement_Count,min(actual_start_dt) as first_Start_dt, max(agmt_end_dt) as last_end_dt
from (
sel  
dagg.src_agreement_num,
'KEEPSAFE' as product_type,
dagg.agreement_type_desc,
dagg.appl_recorded_dt,
dagg.actual_start_dt,
dagg.agmt_end_dt,
dagg.channel_desc,
fpa.hsptlzn_cd,
dagg.requested_by,
--dagg.agreement_category_desc,
dagg.email_opt_out_ind,
dagg.requestor_email,
da.address_id,
da.PREM_SubBuilding_Name, da.PREM_BuildingName,
da.PREM_BuildingNumber, da.PREM_POBox, da.THO_DepThoroughfare,
da.THO_Thoroughfare, da.LOC_DepLocality, da.LOC_Locality, 
da.LOC_PostTown, da.Postcode

from EDW_SCVER_CODA_DIM_VIEWS.v_fct_party_agreement fpa
inner join EDW_SCVER_CODA_DIM_VIEWS.v_dim_agreement dagg -- sel top 10* from edw_scver_coda_dim_views.v_dim_agreement;
on dagg.dim_agreement_id = fpa.agreement_id
and dagg.agreement_type_desc = 'SOCIAL'
and fpa.product_id = 2
inner join edw_scver_coda_accs_views.v_dim_address da ---- sel top 10 * from edw_scver_coda_dim_views.v_dim_address
on fpa.from_address_id = da.address_id
)x
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 
;


create volatile table vt_address_id as
(
sel 
distinct da.address_id
from EDW_SCVER_CODA_DIM_VIEWS.v_fct_party_agreement fpa
inner join EDW_SCVER_CODA_DIM_VIEWS.v_dim_agreement dagg -- sel top 10* from edw_scver_coda_dim_views.v_dim_agreement;
on dagg.dim_agreement_id = fpa.agreement_id
and dagg.agreement_type_desc = 'SOCIAL'
and fpa.product_id = 2
inner join edw_scver_coda_accs_views.v_dim_address da ---- sel top 10 * from edw_scver_coda_dim_views.v_dim_address
on fpa.from_address_id = da.address_id
) with data
on commit preserve rows;




sel top 10 * from 
edw_scver_coda_accs_views.v_sales_transaction st
where st.source_system = 'KOGNITIO';

sel top 10 * from 
edw_scver_coda_accs_views.v_sales_transaction_line;

sel top 10* from
edw_scver_coda_accs_views.v_sales_transaction_line_dtls;




sel count (*) from (
sel distinct pa.party_id, p.party_desc, pa2.address_id, ea.electronic_address 
from edw_scver_coda_accs_views.v_electronic_address ea
inner join   edw_scver_coda_accs_views.v_party_address pa      on pa.address_id = ea.electronic_address_id
inner join   edw_scver_coda_accs_views.v_party p               on p.party_id = pa.party_id
inner join   edw_scver_coda_accs_views.v_party_address pa2     on pa.party_id = pa2.party_id
inner join   vt_address_id vt                                  on vt.address_id = pa2.address_id  
where 1=1
and pa.party_id = pa2.party_id
and pa2.address_type_ID = 1
and p.party_type_id = 1
and pa.address_type_id = 2
)x
;

sel top 10 * from
edw_scver_coda_accs_views.v_party;

sel top 10 * from
edw_scver_coda_accs_views.v_electronic_address;

sel * from
edw_scver_coda_accs_views.v_party_type;


sel count (*) from (  --- 1.19 mill entries
sel --top 10 *
stl.recepient_party_id,
stld.consignee_name,
stld.recip_email_addr
from 
edw_scver_coda_accs_views.v_sales_transaction st
inner join
edw_scver_coda_accs_views.v_sales_transaction_line stl
on st.sales_tran_id = stl.sales_tran_line_id
and st.source_system = 'KOGNITIO'
and stl.recepient_party_id is not null
inner join
edw_scver_coda_accs_views.v_sales_transaction_line_dtls stld
on stl.sales_tran_line_id = stld.sales_tran_line_id
and recip_email_addr is not null
and consignee_name is not null
group by 1,2,3
)x
;

sel top 10 * -- count (*) 
from edw_scver_coda_accs_views.v_sales_transaction_line_dtls;

sel sales_tran_line_id, consignee_name, recip_email_addr from
edw_scver_coda_accs_views.v_sales_transaction_line_dtls
where recip_email_addr is not null
group by 1,2,3;

sel top 10 *--count (*) 
from edw_scver_coda_accs_views.v_sales_transaction_line;

sel stld.consignee_name, stld.recip_email_addr, stl.recepient_party_id  from
edw_scver_coda_accs_views.v_sales_transaction_line stl
inner join edw_scver_coda_accs_views.v_sales_transaction_line_dtls stld
on stld.sales_tran_line_id = stl.sales_tran_line_id
and stl.recepient_party_id is not null
group by 1,2,3;

;