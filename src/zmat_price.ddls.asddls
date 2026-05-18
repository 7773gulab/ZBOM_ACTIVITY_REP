@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMAT_PRICE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMAT_PRICE
  as select from I_ProductValuationBasic as A
{
  key A.Product,
  key A.ValuationArea,
      A.Currency,
      @Semantics.amount.currencyCode: 'Currency'
      max( A.StandardPrice ) as StandardPrice
}
group by
  A.Product,
  A.ValuationArea,
  A.Currency
