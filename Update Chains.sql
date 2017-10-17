/*Creating update links*/  
  
 create table MgrS_LAM.chainingupdate2 as (
 sel dcr.src_redagree_Num, fcr.fct_credo_redirectee_SK_ID, fcr.dim_credo_redirectee_id, dcr.first_name, dcr.surname, fcr.from_scv_address_id , fcr.to_scv_address_id
 from edw_scver_coda_dim_views.v_fct_credo_redirectee  fcr
 inner join EDW_SCVER_CODA_DIM_VIEWS.v_dim_agreement da
 on da.dim_agreement_id = fcr.dim_agreement_id
 and fcr.product_id = 1
 and da.agreement_status_type_desc IN ('ACTIVE','EXPIRED')
 and da.agreement_type_desc = 'SOCIAL'
 and da.agreement_category_desc = 'Original'
 inner join edw_scver_coda_dim_views.v_dim_credo_redirectee dcr
 on da.src_agreement_Num = dcr.src_redagree_Num
 )with data
 ;
 
 /* Creating two redirection chains */
  create table MgrS_LAM.chainingupdate2chain as ( 
  sel 
   x.src_redagree_num as Redagree1, x.first_name, x.surname, x.from_scv_address_id as Add1, x.to_scv_address_id as Add2, 
   y.to_scv_address_id as Add3, y.src_redagree_num as Redagree2
   --count (*) 
   from 
  MgrS_LAM.chainingupdate2 x
  inner join
  MgrS_LAM.chainingupdate2 y
  on x.first_name = y.first_name
  and x.surname = y.surname
  and x.to_scv_address_id = y.from_scv_address_id
  and x.from_scv_address_id <> y.from_scv_address_id
  and x.src_redagree_Num < y.src_redagree_Num
  and x.to_scv_address_id is not null
   and x.to_scv_address_id <> -1
   and x.from_scv_address_id <> -1
  and y.to_scv_address_id is not null
   and y.to_scv_address_id <> -1
   and y.from_scv_address_id <> -1
  
   
   group by 1,2,3,4,5,6,7
  ) with data
  ;
  
  
  /* Creating 3 chain */
  
  create table MgrS_LAM.chainingupdate3chain as ( 
     sel 
   x.Redagree1,x.Redagree2,z.src_redagree_num as  Redagree3, 
   x.first_name, x.surname, x.Add1, x.Add2, x.Add3, z.to_scv_address_id as Add4  
   --*
   --count (*) 
   from 
  MgrS_LAM.chainingupdate2chain x
  inner join
  MgrS_LAM.chainingupdate2 z
  on x.first_name = z.first_name
  and x.surname = z.surname
  and x.Add3 = z.from_scv_address_id
  ---and x.from_scv_address_id <> z.from_scv_address_id
  and x.Redagree2 < z.src_redagree_Num
  and x.Add3 is not null
  and x.Add2 is not null
  and x.Add1 is not null
  and x.Add3 <> -1
  and x.Add2 <> -1
  and x.Add1 <> -1
  and z.to_scv_address_id is not null
  and z.to_scv_address_id <> -1
  and z.from_scv_address_id <> -1
  and x.Redagree1 <> z.src_redagree_Num
  group by 1,2,3,4,5,6,7,8,9 
   
  ) with data
  ;
  
  sel 'totals' as typecount, count(*) from 
  MgrS_LAM.chainingupdate3chain
  union sel 'true' as typecount, count (*) from 
  MgrS_LAM.chainingupdate3chain 
  where add1 <> add2
  and add2 <> add3
  and add3 <> add4
  union sel 'circles' as typecount, count (*) from 
  MgrS_LAM.chainingupdate3chain 
  where add1 <> add2
  	and add2 <> add3
  	and add3 <> add4
  	and add1 =  add4
  ;
  
  
 sel * from 
  MgrS_LAM.chainingupdate3chain 
  where add1 <> add2
  and add2 <> add3
  and add3 <> add4
  ;
  
 /* Creating 4 chains */ 
   create table MgrS_LAM.chainingupdate4chain as ( 
     sel 
   x.Redagree1,x.Redagree2, x.redagree3, z.src_redagree_num as  Redagree4, 
   x.first_name, x.surname, x.Add1, x.Add2, x.Add3, x.add4, z.to_scv_address_id as Add5  
   --*
   --count (*) 
   from 
  MgrS_LAM.chainingupdate3chain x
  inner join
  MgrS_LAM.chainingupdate2 z
  on x.first_name = z.first_name
  and x.surname = z.surname
  and x.Add4 = z.from_scv_address_id
  ---and x.from_scv_address_id <> z.from_scv_address_id
  and x.Redagree3 < z.src_redagree_Num
  and x.Add4 is not null
  and x.Add3 is not null
  and x.Add2 is not null
  and x.Add1 is not null
  and x.Add4 <> -1
  and x.Add3 <> -1
  and x.Add2 <> -1
  and x.Add1 <> -1
  and z.to_scv_address_id is not null
  and z.to_scv_address_id <> -1
  and z.from_scv_address_id <> -1
  and x.Redagree1 <> z.src_redagree_Num
  and x.Redagree2 <> z.src_redagree_Num
  and x.Redagree3 <> z.src_redagree_Num
  and add1 <> add2
  and add2 <> add3
  and add3 <> add4
  and add4 <> add5
  group by 1,2,3,4,5,6,7,8,9,10,11 
   
  ) with data
  ;
  
  sel 
  --* 
  count (*)
  from
  MgrS_LAM.chainingupdate4chain;