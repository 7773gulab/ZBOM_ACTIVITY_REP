@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Mat Data 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCUST_MAT_S2
  as select from    ZCUST_MAT_S          as a
    left outer join I_CustomerMaterial_2 as b on(
      b.SalesOrganization      = a.SalesOrganization
      and b.Product            = a.Product
      and b.MaterialByCustomer = a.MaterialByCustomer
    )
{
  key a.SalesOrganization,
      a.Product,
      a.MaterialByCustomer,
      b.MaterialDescriptionByCustomer ,
      
      case when a.SalesOrganization = '1000'
      then '1100'
       else '2100' end as plant
}
