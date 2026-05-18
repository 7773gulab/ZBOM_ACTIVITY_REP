@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM Activity Report CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBOM_ACTIVITY_CDS
  as select from    I_ProductPlantBasic as a
    left outer join I_Product           as b    on(
         b.Product = a.Product
       )
    left outer join ZCUST_MAT_S         as Z    on(
         Z.Product   = a.Product
         and Z.plant = a.Plant
       )

    left outer join ZMAT_PRICE          as H    on(
         H.Product           = a.Product
         and H.ValuationArea = a.Plant
       )

    left outer join ZBOM_AVL            as BOM  on(
       BOM.Material  = a.Product
       and BOM.Plant = a.Plant
     )
    left outer join ZROUTING_DATA_GROUP as ROUT on(
      ROUT.Product   = a.Product
      and ROUT.Plant = a.Plant
    )
    left outer join ZPRODUCTION_VER     as ver  on(
       ver.Material  = a.Product
       and ver.Plant = a.Plant
     )
//    left outer join ZMAT_COST2           as COST on(
//      COST.Product   = a.Product
//      and COST.Plant = a.Plant
//    )
    left outer join ZPRODUCT_COST1      as COST on(
      COST.Product   = a.Product
      and COST.Plant = a.Plant
    )


{
  key a.Product,
  key a.Plant,
      b.ProductType,
      a.ProductionSchedulingProfile,
      b.CreationDate,
      b.ExternalProductGroup,
      b._ExtProdGrpText[ Language = 'E' ].ExternalProductGroupName as ExternalProductGroupName,
      b._Text[ Language = 'E' ].ProductName                        as ProductName,

      Z.MaterialByCustomer,
      //      Z.MaterialDescriptionByCustomer,

      H.Currency,
      @Semantics.amount.currencyCode: 'Currency'
      H.StandardPrice,
      a.ProcurementType,



      BOM.CreationDate                                             as BOMCreationDate,
      cast(BOM.BOM as abap.char( 10 ) )                            as bomno,

      case when BOM.BOM is not initial
      then 'YES'
      else 'NO' end                                                as BOMAvl,

      case when ver.Material is not initial
      then 'YES'
      else 'NO' end                                                as ProductionVersion,

      ROUT.Product                                                 as Routing_p,

      case when ROUT.Product is not initial
      then 'YES'
      else 'NO' end                                                as ROUTING ,
      
    
      case when COST.Costingmonth = left( $session.system_date, 6 )
      then 'YES'
      when COST.Costingmonth is not initial
      then 'CMNR'
      else 'NO' end                                                as CostReleased 


}
where
  (
       b.ProductType         like 'ZF%'
    or b.ProductType         like 'ZS%'
  )
  and  b.IsMarkedForDeletion <>   'X'
