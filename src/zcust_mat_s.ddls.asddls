@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Mat Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCUST_MAT_S
  as select from I_CustomerMaterial_2 as A
{
  key A.SalesOrganization,
  key A.Product,
      case when A.SalesOrganization = '1000'
      then '1100'
       else '2100' end as plant ,
      max(A.MaterialByCustomer ) as MaterialByCustomer
}

group by
  A.SalesOrganization,
  A.Product
