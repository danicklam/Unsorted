 sel party_id, party_type_id, count (*)
 from EDW_SCVER_CODA_ACCS_VIEWS.v_party_address
 group by 1
 ;
 
 
 create multiset volatile table vt_partyaddress
 as (
 sel pa.party_id, da.address_id from
  EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pa
  inner join
   EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address da
   on da.address_id = pa.address_id
   and da.current_record_ind =1
   and da.postcode like 'EC%' 
   and pa.address_type_id = 1
 ) with data
 primary index (party_id)
 on commit preserve rows 
 ;
 
 sel count (*)
 from vt_partyaddress;
 
  create multiset volatile table vt_addressdupes
 as (
 sel p.party_desc, p.party_type_id, pa.address_id, 
 count (distinct p.party_id) as partycount 
 from vt_partyaddress pa
 inner join
 EDW_SCVER_CODA_ACCS_VIEWS.v_party p
 on p.party_id = pa.party_id
-- and p.party_type_id = 1
 group by 1,2, 3
 having partycount > 1
 ) with data
 on commit preserve rows 
 ;
 
 
 
  sel p.party_id, p.party_desc, p.party_type_id, pa.address_id
 from vt_partyaddress pa
 inner join
 EDW_SCVER_CODA_ACCS_VIEWS.v_party p
 on p.party_id = pa.party_id
-- and p.party_type_id = 1
inner join
 vt_addressdupes ad
 on ad.address_id = pa.address_id
 ;
 
 
 
  sel 
  p.party_desc, p.party_type_id, ad.address_id, p.party_id
  from
  vt_addressdupes ad
  inner join
  EDW_SCVER_CODA_ACCS_VIEWS.v_party p
  on p.address_id = ad.party_id
  ;
 
 
 sel top 10 * from 
  EDW_SCVER_CODA_ACCS_VIEWS.v_party
 ;