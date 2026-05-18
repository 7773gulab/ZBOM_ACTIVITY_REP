@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM Activity Report CUBE'
@Metadata.ignorePropagatedAnnotations: true

@UI: { headerInfo: { typeName: 'Report', typeNamePlural: 'BOM Activity Report'  } }

define root view entity ZBOM_ACTIVITY_CUBE
  as select from ZBOM_ACTIVITY_CDS as A
{

      @UI.selectionField : [{position: 10 }]
      @UI.lineItem       : [{position: 10 }]
      @EndUserText.label: 'Product'
      @Consumption.valueHelpDefinition: [ { entity:  { name:    'ZPRODUCT_F4', element: 'Product' } }]
  key A.Product,
      @UI.lineItem       : [{position: 20 }]
      @EndUserText.label: 'Product Name'
  key A.ProductName,

      @UI.lineItem       : [{position: 30 }]
      @EndUserText.label: 'Customer Ref. '
  key A.MaterialByCustomer,
      //      @UI.lineItem       : [{position: 40 }]
      //      @EndUserText.label: 'Customer Code Des.'
      //  key A.MaterialDescriptionByCustomer,

      @UI.lineItem      : [{ position: 50 }]
      @EndUserText.label: 'Pitch'
      @UI.selectionField: [{ position: 50 }]
      @Consumption.valueHelpDefinition: [ { entity:  { name:    'ZExtProdGrpF4', element: 'ExternalProductGroup' } }]
  key A.ExternalProductGroup,

      @UI.lineItem: [{ position: 60 }]
      @EndUserText.label: 'Pitch Name'
  key A.ExternalProductGroupName,


      @UI.selectionField : [{position: 70}]
      @UI.lineItem       : [{position: 70}]
      @EndUserText.label: 'Plant'
      @Consumption.valueHelpDefinition: [ { entity:  { name:    'ZPLANT_F4', element: 'Plant' } }]
  key A.Plant,
  
      @UI.lineItem       : [{position: 71}]
      @UI.selectionField: [{ position: 50 }]
      @EndUserText.label: 'BOM Creation Date'
  key A.BOMCreationDate,
      @UI.lineItem       : [{position: 71}]
      @EndUserText.label: 'BOM No.'
  key A.bomno,
      @UI.lineItem       : [{position: 80}]
      @EndUserText.label: 'BOM SAP'
  key A.BOMAvl,
      @UI.lineItem       : [{position: 100}]
      @EndUserText.label: 'Routing'
  key case when A.ROUTING = 'YES' and A.BOMAvl = 'NO'
     then 'To Check'
     else A.ROUTING end           as ROUTING,

      @UI.lineItem       : [{position: 110}]
      @EndUserText.label: 'Version'
  key case when A.ProductionVersion = 'YES' and A.BOMAvl = 'NO'
     then 'To Check'
     else A.ProductionVersion end as ProductionVersion,

      @UI.lineItem       : [{position: 120}]
      @EndUserText.label: 'Price'
      @Semantics.amount.currencyCode: 'Currency'
  key A.StandardPrice,

      @UI.lineItem       : [{position: 130}]
      @EndUserText.label: 'Creation Date'
  key A.CreationDate,

      @UI.lineItem       : [{position: 140}]
      @EndUserText.label: 'Product Type'
      @Consumption.valueHelpDefinition: [ { entity:  { name:    'ZPRODUCT_TYPE_F4', element: 'ProductType' } }]
  key A.ProductType,
      @UI.lineItem                : [{ position: 150 }]
      @EndUserText.label          : 'Costing Released Status'    
  key A.CostReleased,
  
  @UI.lineItem       : [{position: 160}]
      @EndUserText.label: 'Procurement Type'
  key A.ProcurementType,
  

  key A.Currency
}
