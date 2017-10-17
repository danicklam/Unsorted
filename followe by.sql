 

sel top 100* from
edw_scver_coda_dim_views.v_fct_credo_redirectee  ;

sel top 100* from
EDW_SCVER_CODA_DIM_VIEWS.v_dim_agreement ;

  sel 
top 100 * 
  from
  MgrS_LAM.chainingsuppress4chain;
  
  
  sel count (*) from 
   MgrS_LAM.chainingsuppress4chain;
  
  
  sel count (*)
  --cu4.*, da.agreement_category_desc, da.followed_by_rdrctn, ard.FK_redirection_num 
  from
    MgrS_LAM.chainingsuppress4chain cu4
    left join
    EDW_SCVER_CODA_DIM_VIEWS.v_dim_agreement da
    on cu4.redagree1 = da.src_agreement_num
	left join
    EDW_SCVER_CODA_ACCS_VIEWS.v_agmt_rdrctn_dtl ard
    on ard.src_agreement_num = cu4.redagree2
    ;
  sel count (*) from (  
     sel --count (*)
  cu4.*, da.agreement_category_desc, da.followed_by_rdrctn, ard.FK_redirection_num 
  from
    MgrS_LAM.chainingsuppress4chain cu4
    inner join
    EDW_SCVER_CODA_DIM_VIEWS.v_dim_agreement da
    on cu4.redagree1 = da.src_agreement_num
	inner join
    EDW_SCVER_CODA_ACCS_VIEWS.v_agmt_rdrctn_dtl ard
    on ard.src_agreement_num = cu4.redagree2 )x
    where fk_redirection_num = 0

    ;
    
    
 sel count (*)
  --cu4.*, da.agreement_category_desc, da.followed_by_rdrctn
  from
    MgrS_LAM.chainingsuppress4chain cu4
    left join
    EDW_SCVER_CODA_DIM_VIEWS.v_dim_agreement da
    on cu4.redagree1 = da.src_agreement_num
    where da.followed_by_rdrctn = 0
    

    ;
    
    
    
    /*Estimate that 30% of records will have a followed by in the chains I have sampled*/