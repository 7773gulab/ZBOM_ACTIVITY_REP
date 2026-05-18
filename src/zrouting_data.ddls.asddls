@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Routing Data CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZROUTING_DATA
  as select from    I_MfgBOOMaterialAssignment   as A
    left outer join I_MfgBOOOperationChangeState as B on(
      B.BillOfOperationsGroup = A.BillOfOperationsGroup
    )
//    left outer join I_BillOfOperations as B on(
//      B.BillOfOperationsGroup = A.BillOfOperationsGroup
//    )

{
  key A.Product,
      A.Plant,
      A.BillOfOperationsType,
      A.BillOfOperationsGroup,
      A.BillOfOperationsVariant,
      A.BOOToMaterialInternalID,
      B.BillOfOperationsGroup as BGROUP



}
where
  B.IsDeleted <> 'X'
