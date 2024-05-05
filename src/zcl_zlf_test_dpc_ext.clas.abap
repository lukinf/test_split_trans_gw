class ZCL_ZLF_TEST_DPC_EXT definition
  public
  inheriting from ZCL_ZLF_TEST_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
protected section.

  methods HEADERSET_CREATE_ENTITY
    redefinition .
  methods HEADERSET_DELETE_ENTITY
    redefinition .
  methods HEADERSET_GET_ENTITY
    redefinition .
  methods HEADERSET_GET_ENTITYSET
    redefinition .
  methods HEADERSET_UPDATE_ENTITY
    redefinition .
  methods ITEMSET_CREATE_ENTITY
    redefinition .
  methods ITEMSET_DELETE_ENTITY
    redefinition .
  methods ITEMSET_GET_ENTITY
    redefinition .
  methods ITEMSET_GET_ENTITYSET
    redefinition .
  methods ITEMSET_UPDATE_ENTITY
    redefinition .
  methods NAMEVALUESET_GET_ENTITYSET
    redefinition .
private section.

  data MO_TRA_MA type ref to /BOBF/IF_TRA_TRANSACTION_MGR .
  data MO_SVC_MA type ref to /BOBF/IF_TRA_SERVICE_MANAGER .

  methods GET_NEW_HDR_ID
    returning
      value(RV_VALUE) type CHAR10 .
ENDCLASS.



CLASS ZCL_ZLF_TEST_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_begin.

    SET UPDATE TASK LOCAL.
    cv_defer_mode = abap_true.

    me->mo_tra_ma = /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( ).
    me->mo_svc_ma = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_lf_test_c=>sc_bo_key ).

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_end.

    me->mo_tra_ma->save( iv_transaction_pattern = /bobf/if_tra_c=>gc_tp_save_and_continue ).

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_process.

    DATA: lo_request_context_c TYPE REF TO /iwbep/if_mgw_req_entity_c,
          lo_request_context_d TYPE REF TO /iwbep/if_mgw_req_entity_d,
          lo_request_context_p TYPE REF TO /iwbep/if_mgw_req_entity_p,
          lo_request_context_u TYPE REF TO /iwbep/if_mgw_req_entity_u.

    DATA: lv_entity_name        TYPE string,
          lt_key_tab            TYPE /iwbep/t_mgw_name_value_pair,
          lt_navigation_path    TYPE /iwbep/t_mgw_navigation_path,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
          ls_item_entity        TYPE zcl_zlf_test_mpc_ext=>ts_item.

    LOOP AT it_changeset_request ASSIGNING FIELD-SYMBOL(<changeset_request>).
      ls_changeset_response-operation_no = <changeset_request>-operation_no.
      CASE <changeset_request>-operation_type.
        WHEN 'CE'.
          lo_request_context_c ?= <changeset_request>-request_context.
          lv_entity_name = lo_request_context_c->get_entity_type_name( ).
          CASE lv_entity_name.
            WHEN 'Header'.

            WHEN 'Item'.
              me->itemset_create_entity(
                EXPORTING
                  it_key_tab              = lt_key_tab
                  iv_entity_name          = lv_entity_name
                  iv_source_name          = lv_entity_name
                  iv_entity_set_name      = lo_request_context_c->get_entity_set_name( )
                  it_navigation_path      = lt_navigation_path
                  io_data_provider        = <changeset_request>-entry_provider
                  io_tech_request_context = lo_request_context_c
                IMPORTING
                  er_entity               = ls_item_entity
              ).
              me->copy_data_to_ref(
                EXPORTING
                  is_data = ls_item_entity
                CHANGING
                  cr_data = ls_changeset_response-entity_data
              ).
          ENDCASE.
        WHEN 'UE'.
          lo_request_context_u ?= <changeset_request>-request_context.
          lv_entity_name = lo_request_context_u->get_entity_type_name( ).
          CASE lv_entity_name.
            WHEN 'Header'.

            WHEN 'Item'.
              me->itemset_update_entity(
                EXPORTING
                  it_key_tab              = lt_key_tab
                  iv_entity_name          = lv_entity_name
                  iv_source_name          = lv_entity_name
                  iv_entity_set_name      = lo_request_context_u->get_entity_set_name( )
                  it_navigation_path      = lt_navigation_path
                  io_data_provider        = <changeset_request>-entry_provider
                  io_tech_request_context = lo_request_context_u
                IMPORTING
                  er_entity               = ls_item_entity
              ).
              me->copy_data_to_ref(
                EXPORTING
                  is_data = ls_item_entity
                CHANGING
                  cr_data = ls_changeset_response-entity_data
              ).
          ENDCASE.
        WHEN 'DE'.
          lo_request_context_d ?= <changeset_request>-request_context.
          lv_entity_name = lo_request_context_d->get_entity_type_name( ).
          CASE lv_entity_name.
            WHEN 'Header'.

            WHEN 'Item'.
              me->itemset_delete_entity(
                it_key_tab              = lt_key_tab
                iv_entity_name          = lv_entity_name
                iv_source_name          = lv_entity_name
                iv_entity_set_name      = lo_request_context_d->get_entity_set_name( )
                it_navigation_path      = lt_navigation_path
                io_tech_request_context = lo_request_context_d
              ).
          ENDCASE.
        WHEN 'CD'.
          lo_request_context_c ?= <changeset_request>-request_context.
          lv_entity_name = lo_request_context_c->get_entity_type_name( ).
          CASE lv_entity_name.
            WHEN 'Header'.
              me->/iwbep/if_mgw_appl_srv_runtime~create_deep_entity(
                EXPORTING
                  io_expand = <changeset_request>-expand_node
                  io_data_provider = <changeset_request>-entry_provider
                IMPORTING
                  er_deep_entity = ls_changeset_response-entity_data
              ).
            WHEN 'Item'.

          ENDCASE.
      ENDCASE.

      APPEND ls_changeset_response TO ct_changeset_response.
      CLEAR: ls_changeset_response.
    ENDLOOP.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.

    DATA: BEGIN OF ls_deep.
            INCLUDE TYPE zcl_zlf_test_mpc=>ts_header.
            DATA hdr_to_itm TYPE zcl_zlf_test_mpc=>tt_item.
    DATA: END OF ls_deep.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: lt_mod TYPE /bobf/t_frw_modification.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_deep ).
    lo_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_lf_test_c=>sc_bo_key ).

    DATA(lr_s_hdr) = NEW zlf_s_hdr( ).
    lr_s_hdr->key  = /bobf/cl_frw_factory=>get_new_key( ).
    lr_s_hdr->id   = me->get_new_hdr_id( ).
    lr_s_hdr->name = ls_deep-name.

    ls_deep-key = lr_s_hdr->key.
    ls_deep-id  = lr_s_hdr->id.

    APPEND INITIAL LINE TO lt_mod ASSIGNING FIELD-SYMBOL(<mod_hdr>).
    <mod_hdr>-change_mode = /bobf/if_frw_c=>sc_modify_create.
    <mod_hdr>-node        = zif_lf_test_c=>sc_node-hdr.
    <mod_hdr>-key         = lr_s_hdr->key.
    <mod_hdr>-data        = lr_s_hdr.

    LOOP AT ls_deep-hdr_to_itm ASSIGNING FIELD-SYMBOL(<item>).
      DATA(lr_s_itm) = NEW zlf_s_itm( ).
      lr_s_itm->parent_key = lr_s_hdr->key.
      lr_s_itm->key        = /bobf/cl_frw_factory=>get_new_key( ).
      lr_s_itm->id         = <item>-id.
      lr_s_itm->name       = <item>-name.
      lr_s_itm->active     = <item>-active.

      <item>-hdr_key = lr_s_hdr->key.
      <item>-key     = lr_s_itm->key.
      <item>-active  = lr_s_itm->active.

      APPEND INITIAL LINE TO lt_mod ASSIGNING FIELD-SYMBOL(<mod_itm>).
      <mod_itm>-change_mode = /bobf/if_frw_c=>sc_modify_create.
      <mod_itm>-source_node = zif_lf_test_c=>sc_node-hdr.
      <mod_itm>-source_key  = lr_s_hdr->key.
      <mod_itm>-association = zif_lf_test_c=>sc_association-hdr-itm.
      <mod_itm>-node        = zif_lf_test_c=>sc_node-itm.
      <mod_itm>-key         = lr_s_itm->key.
      <mod_itm>-data        = lr_s_itm.
    ENDLOOP.

    lo_svc_mngr->modify(
      EXPORTING
        it_modification = lt_mod
      IMPORTING
        eo_message = DATA(lo_message_create)
        eo_change  = DATA(lo_change_create)
    ).

*    IF lo_message_create IS BOUND.
*      IF lo_message_create->check( ) = abap_true.
*        lo_driver->display_messages( lo_message ).
*        me->mo_context->get_message_container( )->add_message_from_bapi(
*          EXPORTING
*            is_bapi_message = aa
*            iv_add_to_response_header = abap_true
*            iv_message_target = '/HederSet(' &&  && ')/'
*         ).
*        RETURN.
*      ENDIF.
*    ENDIF.

    me->copy_data_to_ref(
      EXPORTING
        is_data = ls_deep
      CHANGING
        cr_data = er_deep_entity
    ).
  ENDMETHOD.


  METHOD get_new_hdr_id.

    SELECT MAX( id ) INTO rv_value FROM zlf_d_hdr.
    IF rv_value = 0.
      rv_value = '1000000001'.
    ELSE.
      rv_value = rv_value + 1.
    ENDIF.

  ENDMETHOD.


  METHOD headerset_create_entity.

  ENDMETHOD.


  METHOD headerset_delete_entity.

  ENDMETHOD.


  METHOD headerset_get_entity.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: ls_entity_keys TYPE zcl_zlf_test_mpc_ext=>ts_header,
          lt_hdr_keys    TYPE /bobf/t_frw_key,
          lt_hdrs        TYPE zlf_t_hdr.

    io_tech_request_context->get_converted_keys( IMPORTING es_key_values = ls_entity_keys ).
    lo_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_lf_test_c=>sc_bo_key ).

    APPEND VALUE #( key = ls_entity_keys-key ) TO lt_hdr_keys.

    lo_svc_mngr->retrieve(
      EXPORTING
        iv_node_key  = zif_lf_test_c=>sc_node-hdr
        it_key       = lt_hdr_keys
        iv_fill_data = abap_true
      IMPORTING
        eo_message   = DATA(lo_message)
        et_data      = lt_hdrs
    ).

    er_entity-key  = lt_hdrs[ 1 ]-key.
    er_entity-id   = lt_hdrs[ 1 ]-id.
    er_entity-name = lt_hdrs[ 1 ]-name.

  ENDMETHOD.


  METHOD headerset_get_entityset.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: lt_headers  TYPE zlf_t_hdr,
          lt_hdr_keys TYPE /bobf/t_frw_key.

    lo_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_lf_test_c=>sc_bo_key ).

    lo_svc_mngr->query(
      EXPORTING
        iv_query_key            = zif_lf_test_c=>sc_query-hdr-select_all
        iv_fill_data            = abap_true
      IMPORTING
        eo_message              = DATA(lo_message)
        es_query_info           = DATA(ls_info)
        et_data                 = lt_headers
    ).

    LOOP AT lt_headers ASSIGNING FIELD-SYMBOL(<header>).
      APPEND INITIAL LINE TO et_entityset ASSIGNING FIELD-SYMBOL(<entity>).
      <entity>-key  = <header>-key.
      <entity>-id   = <header>-id.
      <entity>-name = <header>-name.
    ENDLOOP.

    SORT et_entityset BY id DESCENDING.

  ENDMETHOD.


  METHOD headerset_update_entity.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: ls_entity      TYPE zcl_zlf_test_mpc_ext=>ts_header,
          ls_entity_keys TYPE zcl_zlf_test_mpc_ext=>ts_header,
          lt_mod         TYPE /bobf/t_frw_modification.

    io_tech_request_context->get_converted_keys( IMPORTING es_key_values = ls_entity_keys ).
    io_data_provider->read_entry_data( IMPORTING es_data = ls_entity ).
    lo_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_lf_test_c=>sc_bo_key ).

    DATA(lr_s_hdr) = NEW zlf_s_hdr( ).
    lr_s_hdr->key  = ls_entity_keys-key.
    lr_s_hdr->id   = ls_entity-id.
    lr_s_hdr->name = ls_entity-name.

    APPEND INITIAL LINE TO lt_mod ASSIGNING FIELD-SYMBOL(<mod_hdr>).
    <mod_hdr>-change_mode = /bobf/if_frw_c=>sc_modify_update.
    <mod_hdr>-node        = zif_lf_test_c=>sc_node-hdr.
    <mod_hdr>-key         = lr_s_hdr->key.
    <mod_hdr>-data        = lr_s_hdr.

    lo_svc_mngr->modify(
      EXPORTING
        it_modification = lt_mod
      IMPORTING
        eo_message = DATA(lo_message_update)
        eo_change  = DATA(lo_change_update)
    ).

    er_entity = ls_entity.

  ENDMETHOD.


  METHOD itemset_create_entity.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: ls_entity      TYPE zcl_zlf_test_mpc_ext=>ts_item,
          ls_entity_keys TYPE zcl_zlf_test_mpc_ext=>ts_header,
          lt_mod         TYPE /bobf/t_frw_modification.

    io_tech_request_context->get_converted_source_keys( IMPORTING es_key_values = ls_entity_keys ).
    io_data_provider->read_entry_data( IMPORTING es_data = ls_entity ).

    DATA(lr_s_itm) = NEW zlf_s_itm( ).
    lr_s_itm->parent_key = ls_entity_keys-key.
    lr_s_itm->key        = /bobf/cl_frw_factory=>get_new_key( ).
    lr_s_itm->id         = ls_entity-id.
    lr_s_itm->name       = ls_entity-name.
    lr_s_itm->active     = ls_entity-active.

    ls_entity-hdr_key = lr_s_itm->parent_key.
    ls_entity-key     = lr_s_itm->key.

    APPEND INITIAL LINE TO lt_mod ASSIGNING FIELD-SYMBOL(<mod>).
    <mod>-change_mode = /bobf/if_frw_c=>sc_modify_create.
    <mod>-source_node = zif_lf_test_c=>sc_node-hdr.
    <mod>-source_key  = lr_s_itm->parent_key.
    <mod>-association = zif_lf_test_c=>sc_association-hdr-itm.
    <mod>-node        = zif_lf_test_c=>sc_node-itm.
    <mod>-key         = lr_s_itm->key.
    <mod>-data        = lr_s_itm.

    me->mo_svc_ma->modify(
      EXPORTING
        it_modification = lt_mod
      IMPORTING
        eo_message = DATA(lo_message_create)
        eo_change  = DATA(lo_change_create)
    ).

    er_entity = ls_entity.

  ENDMETHOD.


  METHOD itemset_delete_entity.

    DATA: ls_entity_keys TYPE zcl_zlf_test_mpc_ext=>ts_item,
          lt_mod         TYPE /bobf/t_frw_modification.

    io_tech_request_context->get_converted_keys( IMPORTING es_key_values = ls_entity_keys ).

    APPEND INITIAL LINE TO lt_mod ASSIGNING FIELD-SYMBOL(<mod>).
    <mod>-change_mode = /bobf/if_frw_c=>sc_modify_delete.
    <mod>-source_node = zif_lf_test_c=>sc_node-hdr.
    <mod>-source_key  = ls_entity_keys-hdr_key.
    <mod>-node        = zif_lf_test_c=>sc_node-itm.
    <mod>-key         = ls_entity_keys-key.

    me->mo_svc_ma->modify(
      EXPORTING
        it_modification = lt_mod
      IMPORTING
        eo_message = DATA(lo_message_delete)
        eo_change  = DATA(lo_change_delete)
    ).

  ENDMETHOD.


  METHOD itemset_get_entity.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: ls_entity_keys TYPE zcl_zlf_test_mpc_ext=>ts_item,
          lt_itms        TYPE zlf_t_itm,
          lt_hdr_keys    TYPE /bobf/t_frw_key.

    io_tech_request_context->get_converted_keys( IMPORTING es_key_values = ls_entity_keys ).
    lo_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_lf_test_c=>sc_bo_key ).

    APPEND VALUE #( key = ls_entity_keys-hdr_key ) TO lt_hdr_keys.

    lo_svc_mngr->retrieve_by_association(
      EXPORTING
        iv_node_key    = zif_lf_test_c=>sc_node-hdr
        it_key         = lt_hdr_keys
        iv_association = zif_lf_test_c=>sc_association-hdr-itm
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_itms
    ).

    er_entity-hdr_key = lt_itms[ key = ls_entity_keys-key ]-parent_key.
    er_entity-key     = lt_itms[ key = ls_entity_keys-key ]-key.
    er_entity-id      = lt_itms[ key = ls_entity_keys-key ]-id.
    er_entity-name    = lt_itms[ key = ls_entity_keys-key ]-name.
    er_entity-active  = lt_itms[ key = ls_entity_keys-key ]-active.

  ENDMETHOD.


  METHOD itemset_get_entityset.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: ls_entity_keys TYPE zcl_zlf_test_mpc_ext=>ts_header,
          lt_itms        TYPE zlf_t_itm,
          lt_hdr_keys    TYPE /bobf/t_frw_key.

    io_tech_request_context->get_converted_source_keys( IMPORTING es_key_values = ls_entity_keys ).
    lo_svc_mngr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_lf_test_c=>sc_bo_key ).

    APPEND VALUE #( key = ls_entity_keys-key ) TO lt_hdr_keys.

    lo_svc_mngr->retrieve_by_association(
      EXPORTING
        iv_node_key    = zif_lf_test_c=>sc_node-hdr
        it_key         = lt_hdr_keys
        iv_association = zif_lf_test_c=>sc_association-hdr-itm
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_itms
    ).

    LOOP AT lt_itms ASSIGNING FIELD-SYMBOL(<item>).
      APPEND INITIAL LINE TO et_entityset ASSIGNING FIELD-SYMBOL(<entity>).
      <entity>-hdr_key = <item>-parent_key.
      <entity>-key     = <item>-key.
      <entity>-id      = <item>-id.
      <entity>-name    = <item>-name.
      <entity>-active  = <item>-active.
    ENDLOOP.

    SORT et_entityset BY id.

  ENDMETHOD.


  METHOD itemset_update_entity.

    DATA: lo_svc_mngr TYPE REF TO /bobf/if_tra_service_manager.

    DATA: ls_entity      TYPE zcl_zlf_test_mpc_ext=>ts_item,
          ls_entity_keys TYPE zcl_zlf_test_mpc_ext=>ts_item,
          lt_mod         TYPE /bobf/t_frw_modification.

    io_tech_request_context->get_converted_keys( IMPORTING es_key_values = ls_entity_keys ).
    io_data_provider->read_entry_data( IMPORTING es_data = ls_entity ).

    DATA(lr_s_itm) = NEW zlf_s_itm( ).
    lr_s_itm->parent_key  = ls_entity_keys-hdr_key.
    lr_s_itm->key         = ls_entity_keys-key.
    lr_s_itm->id          = ls_entity-id.
    lr_s_itm->name        = ls_entity-name.
    lr_s_itm->active      = ls_entity-active.

    APPEND INITIAL LINE TO lt_mod ASSIGNING FIELD-SYMBOL(<mod>).
    <mod>-change_mode = /bobf/if_frw_c=>sc_modify_update.
    <mod>-source_node = zif_lf_test_c=>sc_node-hdr.
    <mod>-source_key  = ls_entity_keys-hdr_key.
    <mod>-node        = zif_lf_test_c=>sc_node-itm.
    <mod>-key         = ls_entity_keys-key.
    <mod>-data        = lr_s_itm.

    me->mo_svc_ma->modify(
      EXPORTING
        it_modification = lt_mod
      IMPORTING
        eo_message = DATA(lo_message_update)
        eo_change  = DATA(lo_change_update)
    ).

    er_entity = ls_entity.

  ENDMETHOD.


  METHOD namevalueset_get_entityset.

    DATA: ls_entity TYPE zcl_zlf_test_mpc=>ts_namevalue,
          lv_id     TYPE char10.

    DO 10 TIMES.
      lv_id = lv_id + CONV char10( '10' ).
      ls_entity-id = lv_id.
      ls_entity-name = 'Name'.
      APPEND ls_entity TO et_entityset.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
