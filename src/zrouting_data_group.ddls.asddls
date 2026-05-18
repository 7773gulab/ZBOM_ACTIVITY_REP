@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Group Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZROUTING_DATA_GROUP
  as select from ZROUTING_DATA as a
{
  key a.Product,
      a.Plant
}
group by
  a.Product,
  a.Plant
