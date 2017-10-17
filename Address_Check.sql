SELECT AC.Address_Id, 
       AC.Party_Id, AC.Forename, AC.Lastname, FPE.Event_Actual_Date, FPE.Data_Source_Type_Id,
      (DA.Department_Name||' '||DA.Organisation_Name||' '||DA.PREM_SubBuilding_Name||' '||DA.PREM_BuildingName||' '||DA.PREM_BuildingNumber||' '||DA.PREM_POBox||' '||DA.THO_DepThoroughfare||' '||DA.THO_Thoroughfare||' '||DA.LOC_DepLocality||' '||DA.LOC_Locality||' '||DA.LOC_PostTown||' '||DA.Postcode) 
      AS Address
            
FROM
(
SELECT Address_Id, Party_Id, Forename, Lastname FROM EDW_SCVER_CODA_ACCS_VIEWS.v_address_cluster
--WHERE Address_Id IN ('312168826','213168823','326120098','306528777','314864207','329396757','331689727')
WHERE Address_Id = '322977608'
--WHERE Address_Id IN ('331268008','330379577')
--AND Lastname LIKE '% %' AND Forename LIKE '% %'
--('308532987', '315856195', '308398938')
) AC

LEFT JOIN EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event FPE
ON AC.Address_Id = FPE.Recipient_Address_Id AND AC.Party_Id = FPE.Recipient_Party_Id
LEFT JOIN EDW_SCVER_CODA_DIM_VIEWS.v_dim_address DA
ON AC.Address_Id = DA.Address_Id
;


SELECT Address_Id, Party_Id, Forename, Lastname FROM EDW_SCVER_CODA_ACCS_VIEWS.v_address_cluster
--WHERE Address_Id IN ('312168826','213168823','326120098','306528777','314864207','329396757','331689727')
WHERE Address_Id = '322977608';



Sel * From EDW_SCVER_CODA_ACCS_VIEWS.v_party_address
where Address_Id = '322977608';

SEL * FROM EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address
where Address_Id = '322977608';


sel * from EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event where event_actual_date = date '2017-02-01';