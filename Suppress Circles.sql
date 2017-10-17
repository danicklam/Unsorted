 sel * from
 EDW_SCVER_CODA_ACCS_VIEWS.v_agreement
 where src_agreement_num IN (
733341726,
322962620



 )
 ;
 
 sel * from
EDW_SCVER_CODA_DIM_VIEWS.v_dim_credo_redirectee

 where Src_Redagree_Num IN (
733341726,
322962620


 );
 
 
  sel * from
 EDW_SCVER_CODA_DIM_VIEWS.v_fct_credo_redirectee
  where dim_credo_redirectee_id IN (
10894756,
25921615,
25921614,
25921617,
10894755,
10894754,
10894753,
25921616

)
;