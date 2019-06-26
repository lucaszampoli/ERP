<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-store" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-store" class="form-horizontal">
          <ul class="nav nav-tabs">
            <!-- li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li-->
            <li class="active"><a href="#tab-store" data-toggle="tab"><?php echo $tab_store; ?></a></li>
            <li><a href="#tab-local" data-toggle="tab"><?php echo $tab_local; ?></a></li>
            <li><a href="#tab-values" data-toggle="tab">Valores</a></li>
            <li><a href="#tab-payment-type" data-toggle="tab">Bandeiras</a></li>
            <li><a href="#tab-partner" data-toggle="tab">Sócios</a></li>
            <!--li><a href="#tab-image" data-toggle="tab"><?php echo $tab_image; ?></a></li>
            <li><a href="#tab-server" data-toggle="tab"><?php echo $tab_server; ?></a></li-->
          </ul>

          <div class="tab-content">
              <div class="tab-pane" id="tab-partner">
                <?php if(isset( $_GET['store_id']) ) { ?>

                      <!-- Trigger the modal with a button -->
                      <button type="button" id="add-partner" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">
                        <i class="fa fa-user" aria-hidden="true"></i> Adicionar sócio
                      </button>
                    </br>
                    </br>
                      <!-- Modal -->
                      <div id="myModal" class="modal fade" role="dialog">
                        <div class="modal-dialog">
                          <!-- Modal content-->
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title"><i class="fa fa-user" aria-hidden="true"></i> Adicionar sócio</h4>
                            </div>
                              <div class="modal-body">


                              </div>
                              <div class="alert alert-danger modal-alert hide"><i class="fa fa-exclamation-circle"></i>
                                 <span id="modal-error"></span>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                              </div>
                              <div class="modal-footer">
                                <button type="button" id="close-modal" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" id="save-partner" class="btn btn-success">Adicionar</button>
                              </div>
                          </div>

                        </div>
                      </div>
                        <div id="Modaledit" class="modal fade" role="dialog">
                        <div class="modal-dialog">
                          <!-- Modal content-->
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title"><i class="fa fa-user" aria-hidden="true"></i> Editar Sócio</h4>
                            </div>
                              <div class="modal-edit">


                              </div>
                              <div class="alert alert-danger modal-edit-alert hide"><i class="fa fa-exclamation-circle"></i>
                                 <span id="modal-edit-error"></span>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                              </div>
                              <div class="modal-footer">
                                <button type="button" id="close-edit-modal" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" id="edit-partner" class="btn btn-success">Editar</button>
                              </div>
                          </div>

                        </div>
                      </div>
                      <div id="div-partner-list">
                        <?php include('partner_list.tpl'); ?>
                      </div>

              <?php  }else{
                    ?>
                    <h5>Você esta cadastrando uma nova loja. Salve os dados e retorne para cadastrar os sócios.</h5>
                  <?php
                }
                ?>
              </div>

              <div class="tab-pane" id="tab-payment-type">
                <?php if(isset( $_GET['store_id']) ) {?>

                      <!-- Trigger the modal with a button -->
                      <button type="button" id="add-ensign" class="btn btn-info btn-lg" data-toggle="modal" data-target="#Modalensign">
                        <i class="fa fa-credit-card" aria-hidden="true"></i> Adicionar bandeira
                      </button>
                    </br>
                    </br>
                      <!-- Modal -->
                      <div id="Modalensign" class="modal fade" role="dialog">
                        <div class="modal-dialog">
                          <!-- Modal content-->
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title"><i class="fa fa-user" aria-hidden="true"></i> Adicionar bandeira</h4>
                            </div>
                              <div class="modal-ensign">


                              </div>
                              <div class="alert alert-danger modal-alert hide"><i class="fa fa-exclamation-circle"></i>
                                 <span id="modal-error"></span>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                              </div>
                              <div class="modal-footer">
                                <button type="button" id="close-modal-ensign" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" id="save-ensign" class="btn btn-success">Adicionar</button>
                              </div>
                          </div>

                        </div>
                      </div>
                       <div id="Modalstoreensignedit" class="modal fade" role="dialog">
                        <div class="modal-dialog">
                          <!-- Modal content-->
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title"><i class="fa fa-user" aria-hidden="true"></i> Editar bandeira</h4>
                            </div>
                              <div class="modal-store-ensign">


                              </div>
                              <div class="alert alert-danger modal-edit-ensign-alert hide"><i class="fa fa-exclamation-circle"></i>
                                 <span id="modal-edit-ensign-error"></span>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                              </div>
                              <div class="modal-footer">
                                <button type="button" id="close-ensign-edit-modal" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" id="edit-ensign" class="btn btn-success">Editar</button>
                              </div>
                          </div>

                        </div>
                      </div>
                	 <div id="div-ensign-list">
                        <?php include('ensign_list.tpl'); ?>
                      </div>
                	
              <?php   }else{
                    ?>
                    <h5>Você esta cadastrando uma nova loja. Salve os dados e retorne para cadastrar os tipos de pagamento.</h5>
                  <?php
                }
                ?>
              </div>

              <div class="tab-pane" id="tab-values">

                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-email">Valor da loja</label>
                  <div class="col-sm-10">
                    <input type="text" name="store_value" onKeyUp="mascaraMoeda(this, event)" value="<?php echo isset($store_value) && $store_value > 0 ? number_format($store_value, 2,',','.') : '';?>" placeholder="Valor da loja"  class="form-control" />
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-email">Ponto de equilibrio</label>
                  <div class="col-sm-10">
                    <input type="text" name="target" onKeyUp="mascaraMoeda(this, event)" value="<?php echo isset($target) && $target > 0 ? number_format($target, 2,',','.') : '';?>" placeholder="Ponto de equilibrio"  class="form-control" />
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 control-label">Meta Mensal</label>
                  <div class="col-sm-10">
                    <input type="text" name="break_even" onKeyUp="mascaraMoeda(this, event)" value="<?php echo isset($break_even) && $break_even > 0 ? number_format($break_even, 2,',','.') : ''; ?>" placeholder="Meta mensal"  class="form-control" />
                  </div>
                </div>

              </div>

            <div class="tab-pane" id="tab-general">
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-url"><span data-toggle="tooltip" data-html="true" title="<?php echo htmlspecialchars($help_url); ?>"><?php echo $entry_url; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_url" value="<?php echo $config_url; ?>" placeholder="<?php echo $entry_url; ?>" id="input-url" class="form-control" />
                  <?php if ($error_url) { ?>
                  <div class="text-danger"><?php echo $error_url; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-ssl"><span data-toggle="tooltip" data-html="true" title="<?php echo $help_ssl; ?>"><?php echo $entry_ssl; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_ssl" value="<?php echo $config_ssl; ?>" placeholder="<?php echo $entry_ssl; ?>" id="input-ssl" class="form-control" />
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-meta-title"><?php echo $entry_meta_title; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_meta_title" value="<?php echo $config_meta_title; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title" class="form-control" />
                  <?php if ($error_meta_title) { ?>
                  <div class="text-danger"><?php echo $error_meta_title; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-meta-description"><?php echo $entry_meta_description; ?></label>
                <div class="col-sm-10">
                  <textarea name="config_meta_description" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description" class="form-control"><?php echo $config_meta_description; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-meta-keyword"><?php echo $entry_meta_keyword; ?></label>
                <div class="col-sm-10">
                  <textarea name="config_meta_keyword" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword" class="form-control"><?php echo $config_meta_keyword; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-theme"><?php echo $entry_theme; ?></label>
                <div class="col-sm-10">
                  <select name="config_theme" id="input-theme" class="form-control">
                    <?php foreach ($themes as $theme) { ?>
                    <?php if ($theme['value'] == $config_theme) { ?>
                    <option value="<?php echo $theme['value']; ?>" selected="selected"><?php echo $theme['text']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $theme['value']; ?>"><?php echo $theme['text']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                  <br />
                  <img src="" alt="" id="theme" class="img-thumbnail" /></div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-layout"><?php echo $entry_layout; ?></label>
                <div class="col-sm-10">
                  <select name="config_layout_id" id="input-layout" class="form-control">
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if ($layout['layout_id'] == $config_layout_id) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="tab-pane active" id="tab-store">
              <div class="form-group  required">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_name" value="<?php echo $config_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                  <?php if ($error_name) { ?>
                  <div class="text-danger"><?php echo $error_name; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-owner"><?php echo $entry_owner; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_owner" value="<?php echo $config_owner; ?>" placeholder="<?php echo $entry_owner; ?>" id="input-owner" class="form-control" />
                  <?php if ($error_owner) { ?>
                  <div class="text-danger"><?php echo $error_owner; ?></div>
                  <?php } ?>
                </div>
              </div>


              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_email" value="<?php echo $config_email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                  <?php if ($error_email) { ?>
                  <div class="text-danger"><?php echo $error_email; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_telephone" value="<?php echo $config_telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
                  <?php if ($error_telephone) { ?>
                  <div class="text-danger"><?php echo $error_telephone; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label">CNPJ</label>
                <div class="col-sm-10">
                  <input type="text" name="cnpj" value="<?php echo $cnpj; ?>" placeholder="Cnpj" id="input-cnpj" class="form-control" />

                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label">Inscrição estadual</label>
                <div class="col-sm-10">
                  <input type="text" name="ie" value="<?php echo $ie; ?>" placeholder="Inscrição estadual" id="input-ie" class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-cnoj">CCM</label>
                <div class="col-sm-10">
                  <input type="text" name="ccm" value="<?php echo $ccm; ?>" placeholder="Ccm" id="input-ccm" class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-country">Tipo de operação</label>
                <div class="col-sm-10">
                  <select name="type" id="input-type" class="form-control">
                      <?php foreach($types as $type){ ?>
                        <option <?php echo ($store_type_id==$type['store_type_id']) ? 'selected' : '' ?> value="<?php echo $type['store_type_id']; ?>"><?php echo $type['name']; ?></option>
                    <?php  } ?>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-country">Marca</label>
                <div class="col-sm-10">
                  <select name="brand" id="input-brand" class="form-control">
                    <?php foreach($brands as $brand){ ?>
                      <option <?php echo ($brand_id==$brand['brand_id']) ? 'selected' : '' ?> value="<?php echo $brand['brand_id']; ?>"><?php echo $brand['name']; ?></option>
                  <?php  } ?>
                  </select>
                </div>
              </div>

              <?php if ($locations) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_location; ?>"><?php echo $entry_location; ?></span></label>
                <div class="col-sm-10">
                  <?php foreach ($locations as $location) { ?>
                  <div class="checkbox">
                    <label>
                      <?php if (in_array($location['location_id'], $config_location)) { ?>
                      <input type="checkbox" name="config_location[]" value="<?php echo $location['location_id']; ?>" checked="checked" />
                      <?php echo $location['name']; ?>
                      <?php } else { ?>
                      <input type="checkbox" name="config_location[]" value="<?php echo $location['location_id']; ?>" />
                      <?php echo $location['name']; ?>
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
            </div>
            <div class="tab-pane" id="tab-local">
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-address"><?php echo $entry_address; ?></label>
                <div class="col-sm-10">
                  <textarea name="config_address" rows="5" placeholder="<?php echo $entry_address; ?>" id="input-address" class="form-control"><?php echo $config_address; ?></textarea>
                  <?php if ($error_address) { ?>
                  <div class="text-danger"><?php echo $error_address; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-country"><?php echo $entry_country; ?></label>
                <div class="col-sm-10">
                  <select name="config_country_id" id="input-country" class="form-control">
                    <?php foreach ($countries as $country) { ?>
                    <?php if ($country['country_id'] == $config_country_id) { ?>
                    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
                <div class="col-sm-10">
                  <select name="config_zone_id" id="input-zone" class="form-control">
                  </select>
                </div>
              </div>
              <div class="form-group hide">
                <label class="col-sm-2 control-label" for="input-language"><?php echo $entry_language; ?></label>
                <div class="col-sm-10">
                  <select name="config_language" id="input-language" class="form-control">
                    <?php foreach ($languages as $language) { ?>
                    <?php if ($language['code'] == $config_language) { ?>
                    <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group hide">
                <label class="col-sm-2 control-label" for="input-currency"><span data-toggle="tooltip" title="<?php echo $help_currency; ?>"><?php echo $entry_currency; ?></span></label>
                <div class="col-sm-10">
                  <select name="config_currency" id="input-currency" class="form-control">
                    <?php foreach ($currencies as $currency) { ?>
                    <?php if ($currency['code'] == $config_currency) { ?>
                    <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-option">
              <fieldset>
                <legend><?php echo $text_tax; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_tax; ?></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_tax) { ?>
                      <input type="radio" name="config_tax" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_tax" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_tax) { ?>
                      <input type="radio" name="config_tax" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_tax" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-tax-default"><span data-toggle="tooltip" title="<?php echo $help_tax_default; ?>"><?php echo $entry_tax_default; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_tax_default" id="input-tax-default" class="form-control">
                      <option value=""><?php echo $text_none; ?></option>
                      <?php  if ($config_tax_default == 'shipping') { ?>
                      <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                      <?php } else { ?>
                      <option value="shipping"><?php echo $text_shipping; ?></option>
                      <?php } ?>
                      <?php  if ($config_tax_default == 'payment') { ?>
                      <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                      <?php } else { ?>
                      <option value="payment"><?php echo $text_payment; ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-tax-customer"><span data-toggle="tooltip" title="<?php echo $help_tax_customer; ?>"><?php echo $entry_tax_customer; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_tax_customer" id="input-tax-customer" class="form-control">
                      <option value=""><?php echo $text_none; ?></option>
                      <?php  if ($config_tax_customer == 'shipping') { ?>
                      <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                      <?php } else { ?>
                      <option value="shipping"><?php echo $text_shipping; ?></option>
                      <?php } ?>
                      <?php  if ($config_tax_customer == 'payment') { ?>
                      <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                      <?php } else { ?>
                      <option value="payment"><?php echo $text_payment; ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_account; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-customer-group"><span data-toggle="tooltip" title="<?php echo $help_customer_group; ?>"><?php echo $entry_customer_group; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_customer_group_id" id="input-customer-group" class="form-control">
                      <?php foreach ($customer_groups as $customer_group) { ?>
                      <?php if ($customer_group['customer_group_id'] == $config_customer_group_id) { ?>
                      <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_customer_group_display; ?>"><?php echo $entry_customer_group_display; ?></span></label>
                  <div class="col-sm-10">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($customer_group['customer_group_id'], $config_customer_group_display)) { ?>
                        <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                        <?php echo $customer_group['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" />
                        <?php echo $customer_group['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                    <?php if ($error_customer_group_display) { ?>
                    <div class="text-danger"><?php echo $error_customer_group_display; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_customer_price; ?>"><?php echo $entry_customer_price; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_customer_price) { ?>
                      <input type="radio" name="config_customer_price" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_customer_price" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_customer_price) { ?>
                      <input type="radio" name="config_customer_price" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_customer_price" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="<?php echo $help_account; ?>"><?php echo $entry_account; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_account_id" id="input-account" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($informations as $information) { ?>
                      <?php if ($information['information_id'] == $config_account_id) { ?>
                      <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_checkout; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_cart_weight; ?></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_cart_weight) { ?>
                      <input type="radio" name="config_cart_weight" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_cart_weight" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_cart_weight) { ?>
                      <input type="radio" name="config_cart_weight" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_cart_weight" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_checkout_guest; ?>"><?php echo $entry_checkout_guest; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_checkout_guest) { ?>
                      <input type="radio" name="config_checkout_guest" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_checkout_guest" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_checkout_guest) { ?>
                      <input type="radio" name="config_checkout_guest" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_checkout_guest" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-checkout"><span data-toggle="tooltip" title="<?php echo $help_checkout; ?>"><?php echo $entry_checkout; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_checkout_id" id="input-checkout" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($informations as $information) { ?>
                      <?php if ($information['information_id'] == $config_checkout_id) { ?>
                      <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-order-status"><span data-toggle="tooltip" title="<?php echo $help_order_status; ?>"><?php echo $entry_order_status; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_order_status_id" id="input-order-status" class="form-control">
                      <?php foreach ($order_statuses as $order_status) { ?>
                      <?php if ($order_status['order_status_id'] == $config_order_status_id) { ?>
                      <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_stock; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_stock_display; ?>"><?php echo $entry_stock_display; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_stock_display) { ?>
                      <input type="radio" name="config_stock_display" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_display" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_stock_display) { ?>
                      <input type="radio" name="config_stock_display" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_display" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_stock_checkout; ?>"><?php echo $entry_stock_checkout; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_stock_checkout) { ?>
                      <input type="radio" name="config_stock_checkout" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_checkout" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_stock_checkout) { ?>
                      <input type="radio" name="config_stock_checkout" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_checkout" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
              </fieldset>
            </div>
            <div class="tab-pane" id="tab-image">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-logo"><?php echo $entry_logo; ?></label>
                <div class="col-sm-10"><a href="" id="thumb-logo" data-toggle="image" class="img-thumbnail"><img src="<?php echo $logo; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="input-logo" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-icon"><span data-toggle="tooltip" title="<?php echo $help_icon; ?>"><?php echo $entry_icon; ?></span></label>
                <div class="col-sm-10"><a href="" id="thumb-icon" data-toggle="image" class="img-thumbnail"><img src="<?php echo $icon; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>" id="input-icon" />
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-server">
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_secure; ?>"><?php echo $entry_secure; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_secure) { ?>
                    <input type="radio" name="config_secure" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_secure" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_secure) { ?>
                    <input type="radio" name="config_secure" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_secure" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
	
$('select[name=\'config_theme\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=setting/setting/theme&token=<?php echo $token; ?>&theme=' + this.value,
		dataType: 'html',
		beforeSend: function() {
			$('select[name=\'config_theme\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(html) {
			$('#theme').attr('src', html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'config_theme\']').trigger('change');
//--></script>   <script type="text/javascript"><!--
$('select[name=\'config_country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=localisation/country/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'config_country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $config_zone_id; ?>') {
						html += ' selected="selected"';
					}

					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('select[name=\'config_zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});


$('#add-partner').on('click', function()
{

  $(".modal-body").html('');

    $.ajax({
    		url: 'index.php?route=setting/store/getFormAddPartner&&token=<?php echo $token; ?>',
    		dataType: 'html',
    		beforeSend: function() {
    		},
    		complete: function() {
    		},
    		success: function(form) {
            $(".modal-body").html(form);
    		},
    		error: function(xhr, ajaxOptions, thrownError) {
    			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    		}
    	});
});

$('#save-partner').on('click', function() {

  var store = <?php echo $_GET['store_id']; ?>;
  var user = $('#user').val();
  var group = $('#group').val();
  var investiment = $('#investiment').val();
  var percentage = $('#percentage').val();

  $.ajax({
      url: 'index.php?route=setting/store/addStorePartner&&token=<?php echo $token; ?>',
      dataType: 'json',
      data:{ store:store, user:user, group:group, investiment:investiment, percentage:percentage },
      beforeSend: function() {
      },
      complete: function() {
      },
      success: function(id) {

        if(id > 0)
        {
            refreshPartnerList();
            $( "#close-modal" ).trigger( "click" );
        }
        else
        {
          $("#modal-error").html("Algo de errado ao salvar o sócio!");
          $(".modal-alert").removeClass("hide");

        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
});

function refreshPartnerList()
{
  var store = <?php echo $_GET['store_id']; ?>;

  $.ajax({
      url: 'index.php?route=setting/store/getStorePartnerList&token=<?php echo $token; ?>',
      dataType: 'html',
      data:{store:store},
      beforeSend: function() {
      },
      complete: function() {
      },
      success: function(list) {

            $("#div-partner-list").html(list);
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
}
$('.edit_partner').on('click', function()
	{
		var store_partner_id = $(this).attr("data-partner");
		
	  $(".modal-edit").html('');
	
	    $.ajax({
	    		url: 'index.php?route=setting/store/getFormEditPartner&token=<?php echo $token; ?>',
	    		dataType: 'html',
	    		data:{ store_partner_id:store_partner_id },
	    		beforeSend: function() {
	    		},
	    		complete: function() {
	    		},
	    		success: function(form) {
	            $(".modal-edit").html(form);
	    		},
	    		error: function(xhr, ajaxOptions, thrownError) {
	    			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    		}
	    	});
	});

$('#add-ensign').on('click', function()
	{
	  
	  $(".modal-ensign").html('');
	
	    $.ajax({
	    		url: 'index.php?route=setting/store/getFormAddEnsign&&token=<?php echo $token; ?>',
	    		dataType: 'html',
	    		beforeSend: function() {
	    		},
	    		complete: function() {
	    		},
	    		success: function(form) {
	            $(".modal-ensign").html(form);
	    		},
	    		error: function(xhr, ajaxOptions, thrownError) {
	    			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	    		}
	    	});
	});
	
$('#save-ensign').on('click', function() {
	  var store = <?php echo $_GET['store_id']; ?>;
	  var payment_method_id = $('#payment_method_id').val();
	  var ensign_value = $('#ensign_value').val();
	         
	  $.ajax({
	      url: 'index.php?route=setting/store/addStoreEnsign&&token=<?php echo $token; ?>',
	      dataType: 'json',
	      data:{store:store, payment_method_id:payment_method_id, ensign_value:ensign_value},
	      beforeSend: function() {
	      },
	      complete: function() {
	      },
	      success: function(id) {
	
	        if(id > 0)
	        {
	        	refreshEnsignList();
	            $( "#close-modal-ensign" ).trigger( "click" );
	        }
	        else
	        {
	          $("#modal-error").html("Algo de errado ao salvar a bandeira!");
	          $(".modal-alert").removeClass("hide");
	
	        }
	      },
	      error: function(xhr, ajaxOptions, thrownError) {
	        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	      }
	    });
	});
	
function refreshEnsignList()
	{
	  var store = <?php echo $_GET['store_id']; ?>;
	
	  $.ajax({
	      url: 'index.php?route=setting/store/getStoreEnsignList&token=<?php echo $token; ?>',
	      dataType: 'html',
	      data:{store:store},
	      beforeSend: function() {
	      },
	      complete: function() {
	      },
	      success: function(list) {
	
	            $("#div-ensign-list").html(list);
	      },
	      error: function(xhr, ajaxOptions, thrownError) {
	        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	      }
	    });
	}

$('.edit-ensign').on('click', function()
		{
			var store_ensign_id = $(this).attr("data-ensign");
			
		  $(".modal-store-ensign").html('');
		  
		    $.ajax({
		    		url: 'index.php?route=setting/store/getFormEditEnsign&token=<?php echo $token; ?>',
		    		dataType: 'html',
		    		data:{store_ensign_id:store_ensign_id },
		    		beforeSend: function() {
		    		},
		    		complete: function() {
		    		},
		    		success: function(form) {
		            $(".modal-store-ensign").html(form);
		    		},
		    		error: function(xhr, ajaxOptions, thrownError) {
		    			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		    		}
		    	});
		});



$('select[name=\'config_country_id\']').trigger('change');


//--></script>
<script type="text/javascript">

String.prototype.reverse = function(){
	  return this.split('').reverse().join(''); 
	};

	function mascaraMoeda(campo,evento){
	  var tecla = (!evento) ? window.event.keyCode : evento.which;
	  var valor  =  campo.value.replace(/[^\d]+/gi,'').reverse();
	  var resultado  = "";
	  var mascara = "##.###.###,##".reverse();
	  for (var x=0, y=0; x<mascara.length && y<valor.length;) {
	    if (mascara.charAt(x) != '#') {
	      resultado += mascara.charAt(x);
	      x++;
	    } else {
	      resultado += valor.charAt(y);
	      y++;
	      x++;
	    }
	  }
	  campo.value = resultado.reverse();
	}
</script>
</div>
<?php echo $footer; ?>
