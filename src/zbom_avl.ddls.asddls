@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZBOM_AVL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBOM_AVL
  as select from    I_MaterialBOMLink           as A
    left outer join I_BillOfMaterialHeaderDEX_2 as B on(
      B.BillOfMaterial               =  A.BillOfMaterial
      and B.BOMIsArchivedForDeletion <> 'X'
      and B.BillOfMaterialVariant = A.BillOfMaterialVariant
    )
{
  key A.Plant,
  key A.Material,
      A.BillOfMaterial as BOM,
      B.RecordCreationDate as CreationDate 
      
}
where
      B.BOMIsArchivedForDeletion <> 'X'
  and A.BillOfMaterialVariant    =  '01'
  and A.BillOfMaterialCategory   =  'M'
group by
  A.Plant,
  A.Material,
  A.BillOfMaterial,
  B.RecordCreationDate
