class ZCL_ZLF_TEST_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
     TS_HEADER type ZLF_TEST_HDR .
  types:
TT_HEADER type standard table of TS_HEADER .
  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .
  types:
     TS_ITEM type ZLF_TEST_ITM .
  types:
TT_ITEM type standard table of TS_ITEM .
  types:
     TS_NAMEVALUE type ZLF_TEST_NAM .
  types:
TT_NAMEVALUE type standard table of TS_NAMEVALUE .

  constants GC_HEADER type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Header' ##NO_TEXT.
  constants GC_ITEM type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Item' ##NO_TEXT.
  constants GC_NAMEVALUE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'NameValue' ##NO_TEXT.

  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.

  methods DEFINE_VOCAB_ANNOTATIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods IS_SUBSCRIPTION_ENABLED
    returning
      value(RT_SUBSCRIPTION_ENABLED) type ABAP_BOOL
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
private section.

  constants GC_INCL_NAME type STRING value 'ZCL_ZLF_TEST_MPC==============CP' ##NO_TEXT.

  methods DEFINE_HEADER
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_ITEM
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_NAMEVALUE
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_ASSOCIATIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
ENDCLASS.



CLASS ZCL_ZLF_TEST_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'ZLF_TEST_SRV' ).


define_header( ).
define_item( ).
define_namevalue( ).
define_associations( ).
define_vocab_annotations( ).
 IF me->is_subscription_enabled( ) EQ abap_true.
    super->define( ).
  ENDIF.
  endmethod.


  method DEFINE_ASSOCIATIONS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*





data:
lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                   "#EC NEEDED
lo_association    type ref to /iwbep/if_mgw_odata_assoc,                        "#EC NEEDED
lo_ref_constraint type ref to /iwbep/if_mgw_odata_ref_constr,                   "#EC NEEDED
lo_assoc_set      type ref to /iwbep/if_mgw_odata_assoc_set,                    "#EC NEEDED
lo_nav_property   type ref to /iwbep/if_mgw_odata_nav_prop.                     "#EC NEEDED

***********************************************************************************************************************************
*   ASSOCIATIONS
***********************************************************************************************************************************

 lo_association = model->create_association(
                            iv_association_name = 'HDR_ITM' "#EC NOTEXT
                            iv_left_type        = 'Header' "#EC NOTEXT
                            iv_right_type       = 'Item' "#EC NOTEXT
                            iv_right_card       = 'M' "#EC NOTEXT
                            iv_left_card        = '1' ). "#EC NOTEXT

* Referential constraint for association - HDR_ITM
lo_ref_constraint = lo_association->create_ref_constraint( ).
lo_ref_constraint->add_property( iv_principal_property = 'Key'   iv_dependent_property = 'HdrKey' ). "#EC NOTEXT

* Association Sets for association - HDR_ITM
lo_assoc_set = lo_association->create_assoc_set( iv_assoc_set_name = 'HDR_ITM_SET' ). "#EC NOTEXT

***********************************************************************************************************************************
*   NAVIGATION PROPERTIES
***********************************************************************************************************************************

* Navigation Properties for entity - Header
lo_entity_type = model->get_entity_type( iv_entity_name = 'Header' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->create_navigation_property( iv_property_name  = 'HDR_TO_ITM' "#EC NOTEXT
                                                          iv_association_name = 'HDR_ITM' ). "#EC NOTEXT
  endmethod.


  method DEFINE_HEADER.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - Header
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'Header' iv_def_entity_set = abap_false ). "#EC NOTEXT


***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Id' iv_abap_fieldname = 'ID' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'Key' iv_abap_fieldname = 'KEY' ). "#EC NOTEXT

lo_property->set_is_key( ).

lo_property->set_type_edm_guid( ).


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'Name' iv_abap_fieldname = 'NAME' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 70 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).


lo_entity_type->bind_structure( iv_structure_name   = 'ZLF_TEST_HDR'
                                iv_bind_conversions = 'X' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'HeaderSet' ). "#EC NOTEXT
  endmethod.


  method DEFINE_ITEM.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - Item
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'Item' iv_def_entity_set = abap_false ). "#EC NOTEXT


***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Active' iv_abap_fieldname = 'ACTIVE' ). "#EC NOTEXT


lo_property->set_type_edm_boolean( ).


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'HdrKey' iv_abap_fieldname = 'HDR_KEY' ). "#EC NOTEXT

lo_property->set_is_key( ).

lo_property->set_type_edm_guid( ).


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'Id' iv_abap_fieldname = 'ID' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'Key' iv_abap_fieldname = 'KEY' ). "#EC NOTEXT

lo_property->set_is_key( ).

lo_property->set_type_edm_guid( ).


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'Name' iv_abap_fieldname = 'NAME' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 70 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).


lo_entity_type->bind_structure( iv_structure_name   = 'ZLF_TEST_ITM'
                                iv_bind_conversions = 'X' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'ItemSet' ). "#EC NOTEXT
  endmethod.


  method DEFINE_NAMEVALUE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - NameValue
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'NameValue' iv_def_entity_set = abap_false ). "#EC NOTEXT


***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Id' iv_abap_fieldname = 'ID' ). "#EC NOTEXT

lo_property->set_is_key( ).

lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).

lo_property = lo_entity_type->create_property( iv_property_name = 'Name' iv_abap_fieldname = 'NAME' ). "#EC NOTEXT


lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 70 ). "#EC NOTEXT


lo_property->set_nullable( abap_false ).


lo_entity_type->bind_structure( iv_structure_name   = 'ZLF_TEST_NAM'
                                iv_bind_conversions = 'X' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'NameValueSet' ). "#EC NOTEXT
  endmethod.


  method DEFINE_VOCAB_ANNOTATIONS.
data: lo_ann_target type ref to /iwbep/if_mgw_vocan_ann_target.   " Vocabulary Annotation Target                     "#EC NEEDED
DATA: lo_annotation TYPE REF TO /iwbep/if_mgw_vocan_annotation.   " Vocabulary Annotation                            "#EC NEEDED
DATA: lo_collection TYPE REF TO /iwbep/if_mgw_vocan_collection.   " Vocabulary Annotation Collection                 "#EC NEEDED
DATA: lo_function   TYPE REF TO /iwbep/if_mgw_vocan_function.     " Vocabulary Annotation Function                   "#EC NEEDED
DATA: lo_fun_param  TYPE REF TO /iwbep/if_mgw_vocan_fun_param.    " Vocabulary Annotation Function Parameter         "#EC NEEDED
DATA: lo_property   TYPE REF TO /iwbep/if_mgw_vocan_property.     " Vocabulary Annotation Property                   "#EC NEEDED
DATA: lo_record     TYPE REF TO /iwbep/if_mgw_vocan_record.       " Vocabulary Annotation Record                     "#EC NEEDED
DATA: lo_simp_value TYPE REF TO /iwbep/if_mgw_vocan_simple_val.   " Vocabulary Annotation Simple Value               "#EC NEEDED
DATA: lo_url        TYPE REF TO /iwbep/if_mgw_vocan_url.          " Vocabulary Annotation URL                        "#EC NEEDED
DATA: lo_label_elem TYPE REF TO /iwbep/if_mgw_vocan_label_elem.   " Vocabulary Annotation Labeled Element            "#EC NEEDED
DATA: lo_reference  TYPE REF TO /iwbep/if_mgw_vocan_reference.    " Vocabulary Annotation Reference


  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_COMMON'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Common.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_CORE'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Core.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_VALIDATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Validation.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_AGGREGATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'Org.OData.Aggregation.V1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_UI'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.UI.v1' ).    "#EC NOTEXT
  lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_COMMUNICATION'
                                                                iv_vocab_version = '0001').    "#EC NOTEXT
  lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Communication.v1' ).    "#EC NOTEXT


  lo_ann_target = vocab_anno_model->create_annotations_target( 'Header/Name' ).    "#EC NOTEXT
  lo_ann_target->set_namespace_qualifier( 'ZLF_TEST_SRV' ).    "#EC NOTEXT
  lo_annotation = lo_ann_target->create_annotation( iv_term = 'com.sap.vocabularies.Common.v1.FieldControl' ).    "#EC NOTEXT
  lo_simp_value = lo_annotation->create_simple_value( ).
  lo_simp_value->set_enum_member_by_name( 'com.sap.vocabularies.Common.v1.FieldControlType/Mandatory' ).    "#EC NOTEXT
  lo_ann_target = vocab_anno_model->create_annotations_target( 'Header/Name' ).    "#EC NOTEXT
  lo_ann_target->set_namespace_qualifier( 'ZLF_TEST_SRV' ).    "#EC NOTEXT
  lo_annotation = lo_ann_target->create_annotation( iv_term = 'com.sap.vocabularies.Common.v1.ValueList' ).    "#EC NOTEXT
  lo_record = lo_annotation->create_record( iv_record_type = 'com.sap.vocabularies.Common.v1.ValueListType' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'Label' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_string( 'NameValue' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'CollectionPath' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_string( 'NameValueSet' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'CollectionRoot' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_string( '' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'SearchSupported' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_boolean( ' ' ).
  lo_property = lo_record->create_property( 'Parameters' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_collection = lo_property->create_collection( ).
  lo_record = lo_collection->create_record( iv_record_type = 'com.sap.vocabularies.Common.v1.ValueListParameterInOut' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'ValueListProperty' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_string( 'Name' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'LocalDataProperty' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_property_path( 'Name' ).    "#EC NOTEXT
  lo_record = lo_collection->create_record( iv_record_type = 'com.sap.vocabularies.Common.v1.ValueListParameterDisplayOnly' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'ValueListProperty' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_string( 'Id' ).    "#EC NOTEXT
  lo_record = lo_collection->create_record( iv_record_type = 'com.sap.vocabularies.Common.v1.ValueListParameterDisplayOnly' ).    "#EC NOTEXT
  lo_property = lo_record->create_property( 'ValueListProperty' ).   "#EC NOTEXT
  lo_simp_value = lo_property->create_simple_value( ).
  lo_simp_value->set_string( 'Name' ).    "#EC NOTEXT
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20240430154804'.                  "#EC NOTEXT
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
  endmethod.


  method IS_SUBSCRIPTION_ENABLED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*

DATA:
     ls_subscription_enabled TYPE abap_bool value abap_false.

     rt_subscription_enabled = ls_subscription_enabled.
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
     ls_text_element TYPE ts_text_element.                                 "#EC NEEDED


clear ls_text_element.
ls_text_element-artifact_name          = 'Id'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Header'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '001'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'Key'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Header'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '004'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.


clear ls_text_element.
ls_text_element-artifact_name          = 'Active'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Item'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '008'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'HdrKey'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Item'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '005'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'Id'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Item'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '003'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'Key'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Item'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '006'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.


clear ls_text_element.
ls_text_element-artifact_name          = 'Id'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'NameValue'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '010'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
  endmethod.
ENDCLASS.
