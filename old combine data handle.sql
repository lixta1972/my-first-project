/****** SSMS 閻拷 SelectTopNRows 閸涙垝鎶ら惃鍕壖閺堬拷  ******/
--------20200204  v20    12444 3333  222222

  
SELECT TOP (1000) *
	  into  #LIST0099
  FROM [B_GLB_NB_PR].[dbo].[PR01_Planner_upload]
  WHERE  1=1 
 -- AND   ID in (334689,445514 )
 -- or  stock_check_combine_out_target_id=445514
 AND  PR#  LIKE 'NB-Combine%'
 AND  Order_type<>'NB80'
 AND   Created_ON>'2021-12-04'



 
 DROP  TABLE    #LIST001

--閹垫儳鍤璫ombine in and out 閻ㄥ嫭鏆熼幑锟�
SELECT  A.stock_check_combine_in_source_id,B.id AS ID_out,A.id  AS ID_in
into  #LIST001
from  PR01_Planner_upload A   inner  join  PR01_Planner_upload  B  ON A.[stock_check_combine_in_source_id]=B.id
AND  A.ID  IN (SELECT ID FROM #LIST0099)
--where A.status NOT IN (8,9)
 
 SELECT * from #LIST001


  EXEC  [dbo].[PR_Purchase_Package_sub_996_Renew_PR_Node] '445508,445509,445513,445514,445528,445529'

 BEGIN  TRAN
---閺囧瓨鏌奼roup 閺佺増宓� 
 update  PR01_Planner_upload
set [Upside_GROUP_ID]='C_'+CONVERT(VARCHAR(10),BB.ID_IN)+'_'+CONVERT(VARCHAR(10),BB.ID_OUT)
--SELECT *
FROM PR01_Planner_upload AA  INNER JOIN  #LIST001 BB ON AA.id=BB.ID_OUT
where  1=1
--AND  AA.ID NOT IN (SELECT ID FROM #LIST04)
 
 update  PR01_Planner_upload
set [Upside_GROUP_ID]='C_'+CONVERT(VARCHAR(10),BB.ID_IN)+'_'+CONVERT(VARCHAR(10),BB.ID_OUT)
---SELECT *
FROM PR01_Planner_upload AA  INNER JOIN  #LIST001 BB ON AA.id=BB.ID_in
where  1=1
--AND  AA.ID NOT IN (SELECT ID FROM #LIST04)


---閺囩⒖ombine 閺傜懓鎮�
UPDATE  PR01_Planner_upload
SET  Upside_Type_flag=2,upside_out_target_pr_id=NULL,upside_out_qty=0,UPSIDE_IN_QTY=Final_Approve_qty
,order_type='NB80'
--SELECT * FROM PR01_Planner_upload
WHERE   stock_check_combine_in_qty>0
AND  ID  IN (SELECT ID_in FROM  #LIST001)


UPDATE  PR01_Planner_upload
SET  Upside_Type_flag=1,upside_out_qty=stock_check_combine_out_qty,upside_out_target_pr_id=BB.ID_IN
--SELECT *
FROM  PR01_Planner_upload  AA  INNER JOIN  #LIST001   BB  ON  AA.id=BB.ID_out
where  1=1
AND  AA.ID  IN (SELECT ID_out FROM #LIST001)


--SELECT * FROM PR01_Planner_upload


---鐎甸�涚艾瀹歌尙绮＄挧鏉跨暚鐎光剝澹掗敍宀�鏁撻幋鎰煀閻ㄥ嫯藟瀹革拷 PR閿涳拷,閻樿埖锟斤拷  52

insert  into  PR01_Planner_upload
([PR#]
      ,[Order_type]
      ,[FROM_Loc]
      ,[TO_LOC]
      ,[Original_PN]
      , [Original_Qty]
      ,[Original_Vendor_ID]
      ,[Original_Vendor_Name]
      ,[Original_MOQ]
      ,[Original_LT]
      ,[Original_Price]
      ,[Original_category]
      ,[Original_MPQ]
      ,[Original_Vendor_id_source]
      ,[Original_vendor_status]
      ,[Component_PN]
      ,[Created_ON]
      ,[Created_BY]
      ,[Created_Remark]
      ,[PlanOrderDate]
      ,[PlanShipDate]
      ,[PlanRcvDate]
      ,[PlanAvailDate]
      ,[Priority]
      ,[system_verify_status]
      ,[system_verify_info]
      ,[system_verify_date]
      ,[L1_Approve_list]
      ,[L2_Approve_list]
      ,[L3_Approve_list]
      ,[L1_Approved_on]
      ,[L1_Approved_by]
      ,[L1_Approved_remark]
      ,[L1_Approved_Status]
      , [L1_Approved_qty]
      ,[L2_Approved_on]
      ,[L2_Approved_by]
      ,[L2_Approved_remark]
      ,  [L2_Approved_qty]
      ,[L2_Approved_Status]
      ,[L3_Approved_on]
      ,[L3_Approved_by]
      ,[L3_Approved_remark]
      , [L3_Approved_qty]
      ,[L3_Approved_Status]
      ,[L3_Approve_order#]
      ,  [Final_Approve_qty]
      ,[Final_Approve_date]
      ,[Final_Demand_PN]
      ,[Final_vendor_code]
      ,[Final_vendor_name]
      ,[Final_Demand_PN_Price]
      ,[Final_vendor_active_status]
      , status
      ,[IS_Vendor_info_ready]
      ,[Vendor_info_verify_date]
      
      ,[IS_PN_Active]
      ,[cc]
      ,[bu]
      ,[team]
      ,[team2]
      ,[Approve_flow_type]
     
      , [status_for_Aproval_verify]
	  , [Status_upside]
      , [TTL_Supply_solution_qty]
      
      ,[Final_LT]
      ,[Final_MOQ]
      ,[Final_MPQ]
     
    
      ,[lifecylc]
     
      ,[L1_type]
      ,[L2_type]
      ,[L3_type]
      ,[L4_TYPE]
      
      ,[comments_of_hardclose]
      ,[Comments_of_NO_NB_in_LC]
      ,[comments_of_ats_Broker_scrap]
      ,[comments_of_less_than_MOQ]
      ,[comments_of_Inactive_pn]
      ,[comments_of_supply_solution_his]
      ,[comments_of_LTB_Qty_is_0]
      ,[comments_of_ats_his]
      ,[comments_of_Broker_his]
      ,[comments_of_scrap_his]
      ,[Original_PN_upload]
      ,[Original_Vendor_upload]
      ,[Upside_to_ECC_Group_type]
      ,[Upside_Type_flag]
      ,  [upside_out_qty]
	  ,STOCK_CHECK_COMBINE_OUT_QTY
      , [upside_out_target_pr_id] 
      ,[Upside_GROUP_ID]
      ,[source_type_of_upside_Request]
     
      ,  [last_pre_combined_by]
      ,[last_pre_combined_on]
      , [last_final_combined_on]
      ,  [last_dis_combined_on]
	  ,[DUMMY_PR])

SELECT 
      [PR#]
      ,[Order_type]
      ,[FROM_Loc]
      ,[TO_LOC]
      ,[Original_PN]


   --   ,iif( [Final_Approve_qty]>Original_Qty,[Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0),  ISNULL(Original_Qty,0))-ISNULL(stock_check_combine_in_qty,0)AS [Original_Qty]
      ,CASE WHEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)>0  THEN [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)  ELSE   0 END AS [Original_Qty]
	--, ISNULL(Original_Qty,0)-ISNULL(stock_check_combine_in_qty,0)
	 ,[Original_Vendor_ID]
      ,[Original_Vendor_Name]
      ,[Original_MOQ]
      ,[Original_LT]
      ,[Original_Price]
      ,[Original_category]
      ,[Original_MPQ]
      ,[Original_Vendor_id_source]
      ,[Original_vendor_status]
      ,[Component_PN]
      ,[Created_ON]
      ,[Created_BY]
      ,[Created_Remark]
      ,[PlanOrderDate]
      ,[PlanShipDate]
      ,[PlanRcvDate]
      ,[PlanAvailDate]
      ,[Priority]
      ,[system_verify_status]
      ,[system_verify_info]
      ,[system_verify_date]
      ,[L1_Approve_list]
      ,[L2_Approve_list]
      ,[L3_Approve_list]
      ,[L1_Approved_on]
      ,[L1_Approved_by]
      ,[L1_Approved_remark]
      ,[L1_Approved_Status]
  --    ,iif( [Final_Approve_qty]>=Original_Qty,[Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ,  ISNULL(Original_Qty,0))-ISNULL(stock_check_combine_in_qty,0)  AS [L1_Approved_qty]
  -- ,CASE WHEN  [Final_Approve_qty]>Original_Qty  THEN [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)  ELSE   ISNULL(Original_Qty,0)-ISNULL(stock_check_combine_in_qty,0 ) END
   ,CASE WHEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)>0 THEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ELSE 0 END 
 
 --  ,[L1_Approved_qty]-ISNULL(stock_check_combine_in_qty,0)
	 ,[L2_Approved_on]
      ,[L2_Approved_by]
      ,[L2_Approved_remark]
    --  ,iif( [Final_Approve_qty]>=Original_Qty,[Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ,  ISNULL(Original_Qty,0))-ISNULL(stock_check_combine_in_qty,0)   AS [L2_Approved_qty]
   --,CASE WHEN  [Final_Approve_qty]>Original_Qty  THEN [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)  ELSE   ISNULL(Original_Qty,0)-ISNULL(stock_check_combine_in_qty,0 ) END
  -- ,[L2_ApproveD_qty]-ISNULL(stock_check_combine_in_qty,0)
   ,CASE WHEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)>0 THEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ELSE 0 END 
 
	,[L2_Approved_Status]
      ,[L3_Approved_on]
      ,[L3_Approved_by]
      ,[L3_Approved_remark]
 --      ,iif( [Final_Approve_qty]>=Original_Qty,[Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ,  ISNULL(Original_Qty,0))-ISNULL(stock_check_combine_in_qty,0) AS[L3_Approved_qty]
 -- ,CASE WHEN  [Final_Approve_qty]>Original_Qty  THEN [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)  ELSE   ISNULL(Original_Qty,0)-ISNULL(stock_check_combine_in_qty,0 ) END
  --, [L3_ApproveD_qty]-ISNULL(stock_check_combine_in_qty,0) 
   ,CASE WHEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)>0 THEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ELSE 0 END 
 
	 ,[L3_Approved_Status]
      ,[L3_Approve_order#]
    -- ,iif( [Final_Approve_qty]>=Original_Qty,[Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ,  ISNULL(Original_Qty,0))-ISNULL(stock_check_combine_in_qty,0)  AS [Final_Approve_qty]
    --  , [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)
--	,CASE WHEN  [Final_Approve_qty]>Original_Qty  THEN [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)  ELSE   ISNULL(Original_Qty,0)-ISNULL(stock_check_combine_in_qty,0 ) END
	--  ,[Final_Approve_qty]-Original_Qty AS  FF
	 ,CASE WHEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)>0 THEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ELSE 0 END 
 
	  ,[Final_Approve_date]
      ,[Final_Demand_PN]
      ,[Final_vendor_code]
      ,[Final_vendor_name]
      ,[Final_Demand_PN_Price]
      ,[Final_vendor_active_status]
      ,52 AS status
      ,[IS_Vendor_info_ready]
      ,[Vendor_info_verify_date]
      
      ,[IS_PN_Active]
      ,[cc]
      ,[bu]
      ,[team]
      ,[team2]
      ,[Approve_flow_type]
     
      ,52 as [status_for_Aproval_verify]
	  ,52 as  [Status_upside]
      ,[TTL_Supply_solution_qty]
      
      ,[Final_LT]
      ,[Final_MOQ]
      ,[Final_MPQ]
     
    
      ,[lifecylc]
     
      ,[L1_type]
      ,[L2_type]
      ,[L3_type]
      ,[L4_TYPE]
      
      ,[comments_of_hardclose]
      ,[Comments_of_NO_NB_in_LC]
      ,[comments_of_ats_Broker_scrap]
      ,[comments_of_less_than_MOQ]
      ,[comments_of_Inactive_pn]
      ,[comments_of_supply_solution_his]
      ,[comments_of_LTB_Qty_is_0]
      ,[comments_of_ats_his]
      ,[comments_of_Broker_his]
      ,[comments_of_scrap_his]
      ,[Original_PN_upload]
      ,[Original_Vendor_upload]
      ,[Upside_to_ECC_Group_type]
      ,1 as [Upside_Type_flag]
     --  ,iif( [Final_Approve_qty]>=Original_Qty,[Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0),  ISNULL(Original_Qty,0))-ISNULL(stock_check_combine_in_qty,0)  as  [upside_out_qty]
  -- ,[Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)
 -- ,CASE WHEN  [Final_Approve_qty]>Original_Qty  THEN [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)  ELSE   ISNULL(Original_Qty,0)-ISNULL(stock_check_combine_in_qty,0 ) END
    ,CASE WHEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)>0 THEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ELSE 0 END 
    ,CASE WHEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0)>0 THEN  [Final_Approve_qty]-ISNULL(stock_check_combine_in_qty,0) ELSE 0 END 
 
   ,id as  [upside_out_target_pr_id] 
      ,[Upside_GROUP_ID]
      ,[source_type_of_upside_Request]
     
      , created_by as [last_pre_combined_by]
      ,created_on as [last_pre_combined_on]
      ,created_on as [last_final_combined_on]
      ,  [last_dis_combined_on]
	  ,1
  FROM PR01_Planner_upload
  WHERE  1=1
  --Upside_Type_flag=2
--AND  status  NOT  IN  (0,1,2,3,4,5,17,18)
--and  Order_type  not in ('NB80','NB81')
AND  ID  IN (SELECT ID_in FROM  #LIST001)


--AND   ID=334024
--AND  status  NOT  IN  (7,8,9)

-

----閺囧瓨鏌奵ombine in 閻ㄥ嚤R閻ㄥ嫮濮搁幀锟� 

update   AA
SET  [stock_check_combine_in_qty]=BB.[stock_check_combine_OUT_qty]
---SELECT *
FROM PR01_Planner_upload AA  INNER JOIN (SELECT  [Upside_GROUP_ID],SUM([stock_check_combine_OUT_qty]) AS [stock_check_combine_OUT_qty]    FROM  PR01_Planner_upload WHERE [Upside_Type_flag]=1  GROUP BY [Upside_GROUP_ID] )  BB
ON AA.[Upside_GROUP_ID]=BB.[Upside_GROUP_ID]
WHERE  1=1
and  id in  (SELECT  ID_IN FROM  #LIST001)




----瀹歌尙绮＄�光剝澹掔�瑰瞼娈�
UPDATE   PR01_Planner_upload
SET   Status_upside=52,status=52
WHERE   id IN (SELECT  ID_OUT FROM  #LIST001)





 ---鐠侊紕鐣籕ty_Combine_Group
  update  [B_GLB_NB_PR].[dbo].[PR01_Planner_upload]
  set  Qty_Combine_Group=bb.ttl
  FROM  [B_GLB_NB_PR].[dbo].[PR01_Planner_upload] aa inner   join 
  (select [Upside_GROUP_ID],sum([upside_out_qty] ) as  ttl   from [B_GLB_NB_PR].[dbo].[PR01_Planner_upload] where  [Upside_GROUP_ID] is not null group by [Upside_GROUP_ID] ) bb
  on aa.[Upside_GROUP_ID]=bb.Upside_GROUP_ID
  WHERE    id  IN (SELECT  ID_IN FROM  #LIST001)
  

  ----鐠佹澘缍嶉弮鍓佸仯閺勵垰鎯侀弨顖涘瘮娑撳秵寮х粻锟�
update  PR01_Planner_upload
set  [half_carton_support]= case when bb.Half_carton_support ='yes' then 1 else 0 end 
FROM PR01_Planner_upload aa left join [dbo].[VW_PR34_unfilled_carton_support_PN_List] bb
on aa.Original_PN=bb.Lenovo_Fru_PN   and  aa.Original_Vendor_ID=bb.Vendor_Code
where   id  IN (SELECT  ID_IN FROM  #LIST001)


select  Upside_GROUP_ID  AA,* from  PR01_Planner_upload
WHERE 1=1  and  (
 id IN (SELECT  ID_IN FROM  #LIST001) or   upside_out_target_pr_id IN (SELECT  ID_in FROM  #LIST001))
 --AND  Upside_Type_flag=1
ORDER  BY Upside_GROUP_ID,Order_type

BEGIN  TRAN
UPDATE   PR01_Planner_upload
SET   Order_type='NB14'
from  PR01_Planner_upload
WHERE 1=1  and  (
 id IN (SELECT  ID_IN FROM  #LIST001) or   upside_out_target_pr_id IN (SELECT  ID_in FROM  #LIST001))
 AND  Upside_Type_flag=1
 AND  Order_type='NB80'



ROLLBACK

COMMIT