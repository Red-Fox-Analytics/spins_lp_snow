  
with basic_calculations as (

select "Product_Level","Subcategory" ,"Brand" , "Product_Universe" , "UPC" , "Time_Period" ,"Time_Period_End_Date", "geography" , "POSITIONING_GROUP" , "Category" , "COMPANY"
			, "PRODUCT_TYPE" , "DIET_KETO_DIET" , "DIET_PLANT_BASED_DIET" , "FLAVOR" , "INGREDIENT_OAT" , INGREDIENT_SOY_ALLERGEN
			, ingredient_wheat_allergen , labeled_allergen_friendly , labeled_grain_free , labeled_gluten_free , labeled_non_gmo 
			, labeled_organic , pack_count , paleo , "SIZE" AS size_size
			, sum("Units") as unit_sales
			, sum("Units_2_Yago") as unit_sales_2_yago
			, sum("Units_Yago") as unit_sales_yago
			, sum("Dollars") as sales
			, sum("Dollars_2_Yago") as sales_2_yago
			, sum("Dollars_Yago") as sales_yago
			, sum(case when "Dollars_Display_Only" is null then 0 else cast("Dollars_Display_Only" as float) end) as sales_display_only
			, sum(case when  "Dollars_Display_Only_2_Yago" is null then 0 else cast("Dollars_Display_Only_2_Yago" as float) end) as sales_display_only_2_yago
			, sum(case when "Dollars_Display_Only_Yago" is null then 0 else cast("Dollars_Display_Only_Yago" as float) end) as sales_display_only_yago
			, sum(case when "Dollars_Feature_and_Display" is null then 0 else cast("Dollars_Feature_and_Display" as float) end) as sales_feat_and_disp
			, sum(case when "Dollars_Feature_and_Display_2_Yago" is null then 0 else cast("Dollars_Feature_and_Display_2_Yago" as float) end) as sales_feat_and_disp_2_yago
			, sum(case when "Dollars_Feature_and_Display_Yago" is null then 0 else cast("Dollars_Feature_and_Display_Yago" as float) end) as sales_feat_and_disp_yago
			, sum(case when "Dollars_Feature_Only" is null then 0 else cast("Dollars_Feature_Only" as float) end) as sales_feature_only
			, sum(case when "Dollars_Feature_Only_2_Yago" is null then 0 else cast("Dollars_Feature_Only_2_Yago" as float) end) as sales_feature_only_2_yago
			, sum(case when "Dollars_Feature_Only_Yago" is null then 0 else cast("Dollars_Feature_Only_Yago" as float) end) as sales_feature_only_yago
			, sum("Dollars_Promo") as sales_promo
			, sum("Dollars_Promo_2_Yago") as sales_promo_2_yago
			, sum("Dollars_Promo_Yago") as sales_promo_yago
			, sum("Units_Promo") as unit_sales_promo
			, sum("Units_Promo_2_Yago") as unit_sales_promo_2_yago
			, sum("Units_Promo_Yago") as unit_sales_promo_yago
			, sum(case when "Dollars_TPR" is null then 0 else cast("Dollars_TPR" as float) end) as sales_tpr
			, sum(case when "Dollars_TPR_2_Yago" is null then 0 else cast("Dollars_TPR_2_Yago" as float) end) as sales_tpr_2_yago
			, sum(case when "Dollars_TPR_Yago" is null then 0 else cast("Dollars_TPR_Yago" as float) end) as sales_tpr_yago
			, sum("Base_Dollars") as base_sales
			, sum("Base_Dollars_2_Yago") as base_sales_2_yago
			, sum("Base_Dollars_Yago") as base_sales_yago
			, sum(cast("Dollars" as float))-sum(cast("Base_Dollars" as float)) as incremental_sales
			, sum(cast("Dollars_Yago" as float))-sum(cast("Base_Dollars_Yago" as float)) as incremental_sales_yago
			, sum(cast("Dollars_2_Yago" as float))-sum(cast("Base_Dollars_2_Yago" as float)) as incremental_sales_2_yago
			, sum("Base_Units") as base_unit_sales
			, sum("Base_Units_2_Yago") as base_unit_sales_2_yago
			, sum("Base_Units_Yago") as base_unit_sales_yago
			, sum("Base_Units_Promo") as base_unit_sales_promo
			, sum("Base_Units_Promo_2_Yago") as base_unit_sales_promo_2_yago
			, sum("Base_Units_Promo_Yago") as base_unit_sales_promo_yago
			, sum("Base_Dollars_Promo") as base_dollars_Promo
			, sum("Base_Dollars_Promo_Yago") as base_dollars_promo_yago
			, sum("Base_Dollars_Promo_2_Yago") as base_dollars_promo_2_yago
			, sum("TDP") as tdp
			, sum("TDP_2_Yago") as tdp_2_yago
			, sum("TDP_Yago") as tdp_Yago
			, max("Max_percent_ACV") as max_acv 
			, max("Max_percent_ACV_2_Yago") as max_acv_2_yago
			, max("Max_percent_ACV_Yago") as max_acv_yago
			, max("Max_percent_ACV") - max("Max_percent_ACV_2_Yago") as max_acv_pt_chg_2_yago
			, max("Max_percent_ACV") - max("Max_percent_ACV_Yago") as max_acv_pt_chg_yago
			, max("Time_Period_End_Date") as last_update_date
			, max("no_of_Stores_Selling") as stores_selling
			, max("no_of_Stores_Selling_Yago") as stores_selling_yago
			, max("no_of_Stores_Selling_2_Yago") as stores_selling_2_yago
			, max("Number_of_Weeks_Selling") as weeks_selling
			, max("Number_of_Weeks_Selling_2_Yago") as weeks_selling_2_yago
			, max("Number_of_Weeks_Selling_Yago") as weeks_selling_yago
			, avg((case when "SIZE"='' or "SIZE" is null then null else cast("SIZE" as float) end) ) as avg_size
	from {{source('miltons','miltons_spins_lp_2y')}}  --ublic.miltons_spins_lp_2y msly 
	group by "Product_Level","Subcategory" ,"Brand" , "Product_Universe" , "UPC" , "Time_Period" ,"Time_Period_End_Date", "geography" , "POSITIONING_GROUP" , "Category" , "COMPANY"
			, "PRODUCT_TYPE" , "DIET_KETO_DIET" , "DIET_PLANT_BASED_DIET" , "FLAVOR" , "INGREDIENT_OAT" , INGREDIENT_SOY_ALLERGEN
			, ingredient_wheat_allergen , labeled_allergen_friendly , labeled_grain_free , labeled_gluten_free , labeled_non_gmo 
			, labeled_organic , pack_count , paleo , "SIZE"
	limit 10
), level_2 as (
select * 
	, sum(sales) over(partition by "geography","Time_Period","Time_Period_End_Date") total_category_sales
	, sum(sales_yago) over(partition by "geography","Time_Period","Time_Period_End_Date") total_category_sales_yago
	, sum(sales_2_yago) over(partition by "geography","Time_Period","Time_Period_End_Date") total_category_sales_2_yago
	, sum(unit_sales) over(partition by "geography","Time_Period","Time_Period_End_Date") total_category_unit_sales
	, sum(unit_sales_yago) over(partition by "geography","Time_Period","Time_Period_End_Date") total_category_unit_sales_yago
	, sum(unit_sales_2_yago) over(partition by "geography","Time_Period","Time_Period_End_Date") total_category_unit_sales_2_yago
	, sum(tdp) over(partition by "geography","Time_Period","Time_Period_End_Date") total_category_tdp
	, cast(sales_promo as float)/nullif(sales,0) as per_sales_promo
	, cast(sales_promo_2_yago as float)/nullif(sales_2_yago,0) as per_sales_promo_2_yago
	, cast(sales_promo_yago as float)/nullif(sales_yago,0) as per_sales_promo_yago
	, cast(sales_promo as float)/nullif(unit_sales_promo,0) as promo_arp
	, cast(sales_promo_yago as float)/nullif(unit_sales_promo_yago,0) as promo_arp_yago
	, cast(sales_promo_2_yago as float)/nullif(unit_sales_promo_2_yago,0) as promo_arp_2_yago
	, cast(incremental_sales as float)/nullif(sales_promo,0) as per_promo_incrementality
	, cast(incremental_sales_2_yago as float)/nullif(sales_promo_2_yago,0) as per_promo_incrementality_2_yago
	, cast(incremental_sales_yago as float)/nullif(sales_promo_yago,0) as per_promo_incrementality_yago
	, cast(incremental_sales as float)/nullif(sales,0) as per_ttl_dollar_incremental
	, cast(unit_sales_promo as float)/nullif(unit_sales,0) as per_unit_sales_promo
	, cast(unit_sales_promo_2_yago as float)/nullif(unit_sales,0) as per_unit_sales_promo_2_yago
	, cast(unit_sales_promo_yago as float)/nullif(unit_sales,0) as per_unit_sales_promo_yago
	, cast(base_sales as float)/nullif(base_unit_sales,0) base_arp
	, cast(base_sales_yago as float)/nullif(base_unit_sales_yago,0) base_arp_yago
	, cast(base_sales_2_yago as float)/nullif(base_unit_sales_2_yago,0) base_arp_2_yago
	, cast(base_sales as float)/nullif(base_unit_sales,0)
		/nullif(avg_size,0)  as base_arp_per_oz
	, cast(base_sales_yago as float)/nullif(base_unit_sales_yago,0)
		/ nullif(avg_size,0)	as base_arp_per_oz_yago
	, cast(base_sales_2_yago as float)/nullif(base_unit_sales_2_yago,0)
		/ nullif(avg_size,0)	as base_arp_per_oz_2_yago 
	, cast(incremental_sales as float)/nullif(base_dollars_promo,0) lift
	, cast(incremental_sales_yago as float)/nullif(base_dollars_promo_yago,0) lift_yago
	, cast(incremental_sales_2_yago as float)/nullif(base_dollars_promo_2_yago,0) lift_2_yago
	, cast(sales as float)/nullif(sales_2_yago,0) -1 sales_per_change_2_yago
	, cast(sales as float)/nullif(sales_yago,0) -1 sales_per_change_yago
	, cast(sales as float) - nullif(sales_2_yago,0) sales_change_2_yago
	, cast(sales as float) - nullif(sales_yago,0) sales_change_yago
	, cast(sales_display_only as float)/nullif(sales_display_only_2_yago,0) -1 sales_display_only_per_change_2_yago
	, cast(sales_display_only as float)/nullif(sales_display_only_yago,0) -1 sales_display_only_per_change_yago
	, cast(sales as float) - sales_promo sales_non_promo
	, cast(sales_2_yago as float) - sales_promo_2_yago sales_non_promo_2_yago
	, cast(sales_yago as float) - sales_promo_yago sales_non_promo_yago
	, cast(sales_feature_only as float)/nullif(sales_feature_only_2_yago,0) -1 sales_feature_only_per_change_2_yago
	, cast(sales_feature_only as float)/nullif(sales_feature_only_yago,0) -1 sales_feature_only_per_change_yago

	, cast(sales_feat_and_disp as float)/nullif(sales_feat_and_disp_2_yago,0) -1 sales_feat_and_disp_per_change_2_yago
	, cast(sales_feat_and_disp as float)/nullif(sales_feat_and_disp_yago,0) -1 sales_feat_and_disp_per_change_yago
	, cast(sales_promo as float)/nullif(sales_promo_2_yago,0) -1 as sales_promo_per_change_2_yago
	, cast(sales_promo as float)/nullif(sales_promo_yago,0) -1  as sales_promo_per_change_yago
	, cast(sales_tpr as float)/nullif(sales_tpr_yago,0) -1  as sales_tpr_per_change_yago
	, cast(sales_tpr as float)/nullif(sales_tpr_2_yago,0) -1  as sales_tpr_per_change_2_yago
	, cast(sales as float)/nullif(max_acv,0) -1  as sales_acv
	, cast(sales as float)/nullif(max_acv_2_yago,0) -1  as sales_acv_2_yago
	, cast(sales as float)/nullif(max_acv_yago,0) -1  as sales_acv_yago
	, cast(tdp as float)/nullif(max_acv,0) -1  as avg_no_items
	, cast(tdp_2_yago as float)/nullif(max_acv_2_yago,0)   as avg_no_items_2_yago
	, cast(tdp_yago as float)/nullif(max_acv_yago,0)   as avg_no_items_yago
	, cast(sales as float)/nullif(unit_sales,0)   as arp
	, cast(sales_2_yago as float)/nullif(unit_sales_2_yago,0)   as arp_2_yago
	, cast(sales_yago as float)/nullif(unit_sales_yago,0)   as arp_yago
	, cast(unit_sales as float) - nullif(base_unit_sales,0) incremental_unit_sales
	, cast(unit_sales_2_yago as float) - base_unit_sales_2_yago incremental_unit_sales_2_yago
	, cast(unit_sales_yago as float) - base_unit_sales_yago incremental_unit_sales_yago
	, cast(sales_promo as float)/nullif(unit_sales_promo,0)/nullif(avg_size,0)    as promo_arp_per_oz
	, cast(sales_promo_2_yago as float)/nullif(unit_sales_promo_2_yago,0)/nullif(avg_size,0)    as promo_arp_per_oz_2_yago
	, cast(sales_promo_yago as float)/nullif(unit_sales_promo_yago,0)/nullif(avg_size,0)    as promo_arp_per_oz_yago
	, cast(stores_selling as float)/nullif(stores_selling_2_yago,0)   as stores_selling_per_change_2_yago
	, cast(stores_selling as float)/nullif(stores_selling_yago,0)   as stores_selling_per_change_yago	
	, cast(tdp as float)/nullif(tdp_2_yago,0) -1  as tdp_per_change_2_yago
	, cast(tdp as float)/nullif(tdp_yago,0) -1  as tdp_per_change_yago
	, cast(tdp as float)- tdp_2_yago  as tdp_change_2_yago
	, cast(tdp as float)- tdp_yago  as tdp_change_yago 
	, cast(unit_sales as float)/nullif(unit_sales_2_yago,0) -1  as unit_sales_per_change_2_yago	
	, cast(unit_sales as float)/nullif(unit_sales_yago,0) -1   as unit_sales_per_change_yago
	, cast(unit_sales as float)-unit_sales_2_yago  as unit_sales_change_2_yago	
	, cast(unit_sales as float)-unit_sales_yago  as unit_sales_change_yago
	, cast(unit_sales_2_yago as float)-unit_sales_promo_2_yago  as unit_sales_non_promo_2_yago
	, cast(unit_sales_yago as float)-unit_sales_promo_yago  as unit_sales_non_promo_yago	
	, cast(unit_sales_promo as float)/nullif(unit_sales_promo_2_yago,0) -1   as unit_sales_promo_per_change_2_yago	
	, cast(unit_sales_promo as float)/nullif(unit_sales_promo_yago,0) -1   as unit_sales_promo_per_change_yago
	, cast(base_sales as float)/nullif(base_sales_2_yago,0) -1   as base_sales_per_change_2_yago
	, cast(base_sales as float)/nullif(base_sales_yago,0) -1   as base_sales_per_change_yago
	, cast(base_sales as float)/nullif(tdp,0)    as base_sales_tdp
	, cast(base_sales_2_yago as float)/nullif(tdp_2_yago,0)    as base_sales_tdp_2_yago
	, cast(base_sales_yago as float)/nullif(tdp_yago,0)    as base_sales_tdp_yago
	, (cast(base_sales as float)/nullif(tdp,0))/nullif(cast(base_sales as float)/nullif(tdp_2_yago,0),0)    as base_sales_tdp_per_change_2_yago
	, (cast(base_sales as float)/nullif(tdp,0))/nullif(cast(base_sales as float)/nullif(tdp_yago,0),0)    as base_sales_tdp_per_change_yago
	, cast(base_unit_sales as float)/nullif(tdp,0) as base_unit_sales_tdp
	, cast(base_unit_sales_2_yago as float)/nullif(tdp_2_yago,0) as base_unit_sales_tdp_2_yago
	, cast(base_unit_sales_yago as float)/nullif(tdp_yago,0) as base_unit_sales_tdp_yago
	, (cast(base_unit_sales as float)/nullif(tdp,0))/nullif(cast(base_unit_sales_2_yago as float)/nullif(tdp_2_yago,0),0) as base_unit_sales_tdp_per_change_2_yago
	, (cast(base_unit_sales as float)/nullif(tdp,0))/nullif(cast(base_unit_sales_yago as float)/nullif(tdp_yago,0),0) as base_unit_sales_tdp_per_change_yago
	, cast(base_unit_sales as float)/nullif(base_unit_sales_2_yago,0) -1   as base_unit_sales_per_change_2_yago
	, cast(base_unit_sales as float)/nullif(base_unit_sales_yago,0) -1   as base_unit_sales_per_change_yago
	, cast(sales as float)/nullif(stores_selling,0) as sales_stores_selling
	, cast(sales_2_yago as float)/nullif(stores_selling_2_yago,0) as sales_stores_selling_2_yago
	, cast(sales_yago as float)/nullif(stores_selling_yago,0) as sales_stores_selling_yago
	, (cast(sales as float)/nullif(stores_selling,0))/nullif(cast(sales_2_yago as float)/nullif(stores_selling_2_yago,0),0) -1 as sales_stores_selling_per_change_2_yago
	, (cast(sales as float)/nullif(stores_selling,0))/nullif(cast(sales_yago as float)/nullif(stores_selling_yago,0),0) -1 as sales_stores_selling_per_change_yago
	, cast(sales as float)/nullif(tdp,0) as sales_tdp
	, cast(sales_yago as float)/nullif(tdp_yago,0) as sales_tdp_yago
	, cast(nullif(sales_2_yago,0) as float)/nullif(tdp_2_yago,0) as sales_tdp_2_yago
	, nullif((cast(sales as float)/nullif(tdp,0)),0)/nullif(cast(nullif(sales_2_yago,0) as float)/nullif(tdp_2_yago,0),0) -1 as sales_tdp_per_change_2_yago
	, nullif((cast(sales as float)/nullif(tdp,0)),0)/nullif(cast(nullif(sales_yago,0) as float)/nullif(tdp_yago,0),0) -1 as sales_tdp_per_change_yago
	, nullif((cast(sales as float)/nullif(tdp,0)),0) - (cast(nullif(sales_yago,0) as float)/nullif(tdp_yago,0))  as sales_tdp_change_yago
	, (cast(nullif(sales,0) as float)/nullif(weeks_selling,0))*52 as annualized_sales
	, (cast(nullif(sales_2_yago,0) as float)/nullif(weeks_selling_2_yago,0))*52 as annualized_sales_2_yago
	, (cast(nullif(sales_yago,0) as float)/nullif(weeks_selling_yago,0))*52 as annualized_sales_yago
	, (cast(nullif(sales_yago,0) as float)/nullif(weeks_selling_yago,0))*52 as annualized_unit_sales
	, (cast(unit_sales_2_yago as float)/nullif(weeks_selling_2_yago,0))*52 as annualized_unit_sales_2_yago
	, (cast(unit_sales_yago as float)/nullif(weeks_selling_yago,0))*52 as annualized_unit_sales_yago
	, cast(incremental_sales as float)/nullif(incremental_sales_2_yago,0) -1 as incremental_sales_per_change_2_yago
	, cast(incremental_sales as float)/nullif(incremental_sales_yago,0) -1 as incremental_sales_per_change_yago
	, cast(unit_sales as float)/nullif(max_acv,0) as unit_sales_acv
	, cast(unit_sales_2_yago as float)/nullif(max_acv_2_yago,0) as unit_sales_acv_2_yago
	, cast(unit_sales_yago as float)/nullif(max_acv_yago,0) as unit_sales_acv_yago
	, (cast(unit_sales as float)/nullif(max_acv,0))/nullif((cast(unit_sales_2_yago as float)/nullif(max_acv_2_yago,0)),0) -1 as unit_sales_acv_per_change_2_yago
	, (cast(unit_sales as float)/nullif(max_acv,0))/nullif((cast(unit_sales_yago as float)/nullif(max_acv_yago,0)),0) -1 as unit_sales_acv_per_change_yago
    , cast(unit_sales as float)/nullif(stores_selling,0) as unit_sales_stores_selling
    , nullif(cast(unit_sales_2_yago as float),0)/nullif(stores_selling_2_yago,0) as unit_sales_stores_selling_2_yago
    , nullif(cast(unit_sales_yago as float),0)/nullif(stores_selling_yago,0) as unit_sales_stores_selling_yago
    , (cast(unit_sales as float)/nullif(stores_selling,0))/nullif(cast(unit_sales_2_yago as float)/nullif(stores_selling_2_yago,0),0) -1 as unit_sales_stores_selling_per_change_2_yago
    , (cast(unit_sales as float)/nullif(stores_selling,0))/nullif(cast(unit_sales_yago as float)/nullif(stores_selling_yago,0),0) -1 as unit_sales_stores_selling_per_change_yago
	, cast(unit_sales as float)/nullif(tdp,0) as unit_sales_tdp
	, cast(unit_sales_2_yago as float)/nullif(tdp_2_yago,0) as unit_sales_tdp_2_yago
	, cast(unit_sales_yago as float)/nullif(tdp_yago,0) as unit_sales_tdp_yago
	, (cast(unit_sales as float)/nullif(tdp,0))/nullif((cast(unit_sales_2_yago as float)/nullif(tdp_2_yago,0)),0) -1 unit_sales_tdp_per_change_2_yago
	, (cast(unit_sales as float)/nullif(tdp,0))/nullif((cast(unit_sales_yago as float)/nullif(tdp_yago,0)),0) -1 unit_sales_tdp_per_change_yago
from basic_calculations
), level_3 as (
select *
	, (per_sales_promo/nullif(per_sales_promo_2_yago,0))*100 as per_sales_promo_pt_chg_2_yago
	, (per_sales_promo/nullif(per_sales_promo_yago,0))*100 as per_sales_promo_pt_chg_yago
	, case when promo_arp < base_arp then ((promo_arp/nullif(base_arp,0))-1) ELSE 0 end per_discount_promo
	, case when promo_arp_2_yago < base_arp_2_yago then ((promo_arp_2_yago/nullif(base_arp_2_yago,0))-1) ELSE 0 end per_discount_promo_2_yago
	, case when promo_arp_yago < base_arp_yago then ((promo_arp_yago/nullif(base_arp_yago,0))-1) ELSE 0 end per_discount_promo_yago
	, 1- per_promo_incrementality as per_promo_subsidized_base
	, (per_unit_sales_promo- per_unit_sales_promo_2_yago)*100 as per_unit_sales_promo_pt_chg_2_yago
	, (per_unit_sales_promo- per_unit_sales_promo_yago)*100 as per_unit_sales_promo_pt_chg_yago
	, tdp_change_yago*(sales_non_promo_yago/nullif(tdp_yago,0))*0.7 as change_due_to_distribution
	, tdp_change_2_yago*(sales_non_promo_2_yago/nullif(tdp_2_yago,0))*0.7 as change_due_to_distribution_2_yago
	, base_arp- base_arp_2_yago as base_arp_pt_change_2_yago
	, base_arp- base_arp_yago as base_arp_pt_change_yago
	, (base_arp- base_arp_yago)*(base_unit_sales_yago) as change_due_to_pricing
	, (base_arp- base_arp_2_yago)*(base_unit_sales_2_yago) as change_due_to_pricing_2_yago
	, incremental_sales-incremental_sales_yago as change_due_to_promotion
	, incremental_sales-incremental_sales_2_yago as change_due_to_promotion_2_yago
	, promo_arp- base_arp as discount_promo
	, promo_arp_2_yago- base_arp_2_yago as discount_promo_2_yago
	, promo_arp_yago- base_arp_yago as discount_promo_yago
	, (lift-lift_2_yago)*100 as lift_pt_change_2_yago
	, (lift-lift_yago)*100 as lift_pt_change_yago
	, sales_non_promo/nullif(sales_non_promo_2_yago,0) -1 as sales_non_promo_pt_change_2_yago
	, sales_non_promo/nullif(sales_non_promo_yago,0) -1 as sales_non_promo_pt_change_yago
	, sales_acv/nullif(sales_acv_2_yago,0) -1 as sales_acv_per_change_2_yago
	, sales_acv/nullif(sales_acv_yago,0) -1 as sales_acv_per_change_yago
	, stores_selling*avg_no_items as gdp 
	, stores_selling_2_yago*avg_no_items_2_yago as gdp_2_yago
	, stores_selling_yago*avg_no_items_yago as gdp_yago
	, (stores_selling*avg_no_items)/nullif(stores_selling_2_yago*avg_no_items_2_yago,0) -1 gdp_per_change_2_yago
	, (stores_selling*avg_no_items)/nullif(stores_selling_yago*avg_no_items_yago,0) -1 gdp_per_change_yago
	, sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0) as sales_stores_weeks_avg_no_items
	, sales_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0) as sales_stores_weeks_avg_no_items_2_yago
	, sales_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0) as sales_stores_weeks_avg_no_items_yago
	, (sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/
		nullif(sales_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0),0) -1 as sales_stores_weeks_avg_no_items_per_change_2_yago
	, (sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/
		nullif(sales_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0),0) -1 as sales_stores_weeks_avg_no_items_per_change_yago
	, annualized_sales/nullif(annualized_sales_2_yago,0) -1 as annualized_sales_per_change_2_yago
	, annualized_sales/nullif(annualized_sales_yago,0) -1 as annualized_sales_per_change_yago
	, annualized_sales/nullif(tdp,0) as annualized_sales_tdp
	, annualized_sales_yago/nullif(tdp_yago,0) as annualized_sales_tdp_yago
	, annualized_unit_sales/nullif(tdp,0) as annualized_unit_sales_tdp
	, annualized_unit_sales_yago/nullif(tdp_yago,0) as annualized_unit_sales_tdp_yago
	, annualized_unit_sales/nullif(annualized_unit_sales_2_yago,0) -1 as annualized_unit_sales_per_change_2_yago
	, annualized_unit_sales/nullif(annualized_unit_sales_yago,0) -1 as annualized_unit_sales_per_change_yago
	, arp/nullif(arp_yago,0) as arp_per_change_yago
	, arp - arp_yago as arp_pt_change_yago
	, arp - arp_2_yago as arp_pt_change_2_yago
	, avg_no_items/nullif(avg_no_items_2_yago,0) -1 as avg_no_items_per_change_2_yago
	, avg_no_items/nullif(avg_no_items_yago,0) -1 as avg_no_items_per_change_yago
	, base_arp/nullif(base_arp_yago,0) -1 as base_arp_per_change_yago

	, base_unit_sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0) as base_unit_sales_stores_weeks_avg_no_items
	, base_unit_sales_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0) as base_unit_sales_stores_weeks_avg_no_items_2_yago
	, base_unit_sales_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0) as base_unit_sales_stores_weeks_avg_no_items_yago
	, (base_unit_sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/nullif(base_unit_sales_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0),0) -1 as base_unit_sales_stores_weeks_avg_no_items_per_change_2_yago
	, (base_unit_sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/nullif(base_unit_sales_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0),0) -1 as base_unit_sales_stores_weeks_avg_no_items_per_change_yago	
	, incremental_unit_sales/nullif(incremental_unit_sales_2_yago,0) -1 as incremental_unit_sales_per_change_2_yago
	, incremental_unit_sales/nullif(incremental_unit_sales_yago,0) -1 as incremental_unit_sales_per_change_yago
	, promo_arp/nullif(promo_arp_yago,0) -1 as promo_arp_per_change_yago
	, promo_arp-promo_arp_2_yago as promo_arp_pt_change_2_yago
	, promo_arp-promo_arp_yago as promo_arp_pt_change_yago
	, unit_sales_promo/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0) as unit_sales_promo_stores_weeks_avg_no_items
	, unit_sales_promo_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0) as unit_sales_promo_stores_weeks_avg_no_items_2_yago
	, unit_sales_promo_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0) as unit_sales_promo_stores_weeks_avg_no_items_yago
	, (unit_sales_promo/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/nullif(unit_sales_promo_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0),0) -1 as unit_sales_promo_stores_weeks_avg_no_items_per_change_2_yago
	, (unit_sales_promo/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/nullif(unit_sales_promo_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0),0) -1 as unit_sales_promo_stores_weeks_avg_no_items_per_change_yago
	, incremental_unit_sales/nullif(base_unit_sales_promo,0) as unit_lift
	, incremental_unit_sales_2_yago/nullif(base_unit_sales_promo_2_yago,0) as unit_lift_2_yago
	, incremental_unit_sales_yago/nullif(base_unit_sales_promo_yago,0) as unit_lift_yago
	, ((incremental_unit_sales/nullif(base_unit_sales_promo,0))- (incremental_unit_sales_2_yago/nullif(base_unit_sales_promo_2_yago,0))	)*100 as unit_lift_pt_change_2_yago
	, ((incremental_unit_sales/nullif(base_unit_sales_promo,0))- (incremental_unit_sales_yago/nullif(base_unit_sales_promo_yago,0))	)*100 as unit_lift_pt_change_yago
	, unit_sales_promo/nullif(unit_sales_non_promo_2_yago,0) as unit_sales_non_promo_per_change_2_yago
	, unit_sales_promo/nullif(unit_sales_non_promo_yago,0) as unit_sales_non_promo_per_change_yago
	, unit_sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0) as unit_sales_stores_weeks_avg_no_items
	, unit_sales_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0) as unit_sales_stores_weeks_avg_no_items_2_yago
	, unit_sales_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0) as unit_sales_stores_weeks_avg_no_items_yago
	, (unit_sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/nullif(unit_sales_2_yago/nullif(weeks_selling_2_yago,0)/nullif(stores_selling_2_yago,0)/nullif(avg_no_items_2_yago,0),0) unit_sales_stores_weeks_avg_no_items_per_change_2_yago_raw
	, (unit_sales/nullif(weeks_selling,0)/nullif(stores_selling,0)/nullif(avg_no_items,0))
		/nullif(unit_sales_yago/nullif(weeks_selling_yago,0)/nullif(stores_selling_yago,0)/nullif(avg_no_items_yago,0) ,0) unit_sales_stores_weeks_avg_no_items_per_change_yago_raw	
	
	, sales/nullif(unit_sales,0)/nullif(avg_size,0) as arp_per_oz
	, sales_2_yago/nullif(unit_sales_2_yago,0)/nullif(avg_size,0) as arp_per_oz_2_yago
	, sales_yago/nullif(unit_sales_yago,0)/nullif(avg_size,0) as arp_per_oz_yago
	, sales/nullif(total_category_sales,0)*100 as dollar_share
	, sales_2_yago/nullif(total_category_sales_2_yago,0)*100 as dollar_share_2_yago
	, sales_yago/nullif(total_category_sales_yago,0)*100 as dollar_share_yago
	, (sales/nullif(total_category_sales,0)*100) -(sales_2_yago/nullif(total_category_sales_2_yago,0)*100) dollar_share_pt_change_2_yago
	, (sales/nullif(total_category_sales,0)*100) -(sales_yago/nullif(total_category_sales_yago,0)*100) dollar_share_pt_change_yago
	, tdp/nullif(total_category_tdp,0)*100 as tdp_share
	, cast(unit_sales as float)/nullif(total_category_unit_sales,0)*100 as unit_share
	, unit_sales_2_yago/nullif(total_category_unit_sales_2_yago,0)*100 as unit_share_2_yago
	, unit_sales_yago/nullif(total_category_unit_sales_yago,0)*100 as unit_share_yago
	, (unit_sales/nullif(total_category_unit_sales,0)*100) -(unit_sales_2_yago/nullif(total_category_unit_sales_2_yago,0)*100) unit_share_pt_change_2_yago
	, (unit_sales/nullif(total_category_unit_sales,0)*100) -(unit_sales_yago/nullif(total_category_unit_sales_yago,0)*100) unit_share_pt_change_yago
from level_2
)
select *
	, sales_change_yago-(change_due_to_distribution+change_due_to_pricing+change_due_to_promotion) change_due_to_velocity_ao
	, sales_change_2_yago-(change_due_to_distribution_2_yago+change_due_to_pricing_2_yago+change_due_to_promotion_2_yago) change_due_to_velocity_ao_2_yago
	, sales/nullif(gdp,0) sales_gdp
	, unit_sales/nullif(gdp,0) unit_sales_gdp
	, case when abs(unit_sales_stores_weeks_avg_no_items_per_change_2_yago_raw) >10 then null else unit_sales_stores_weeks_avg_no_items_per_change_2_yago_raw-1 end as unit_sales_stores_weeks_avg_no_items_per_change_2_yago
	, case when abs(unit_sales_stores_weeks_avg_no_items_per_change_yago_raw) >10 then null else unit_sales_stores_weeks_avg_no_items_per_change_yago_raw-1 end as unit_sales_stores_weeks_avg_no_items_per_change_yago
	
from level_3 
--select distinct size_size from public.miltons_spins_lp_2y msly limit 10)																																																									
