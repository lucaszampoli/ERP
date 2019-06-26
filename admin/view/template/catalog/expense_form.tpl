<?php echo $header; ?><?php echo $column_left; ?>


<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-category" class="form-horizontal">
          <div class="form-group">
            <table width="100%">
              <tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name2">Nome:</label>
                    <div class="col-sm-8">
                      <input type="text" name="expense_description" value="<?php echo isset($expense_info['expense_description']) ? $expense_info['expense_description'] : '' ?>" placeholder="Informe a despesa" id="expense_description" class="form-control">
                      <input type="hidden" name="expense_id" value="<?php echo ($expense_info['expense_id']) ? $expense_info['expense_id'] : '' ?>"  id="expense_id" class="form-control">
                    </div>
                  </div>
                </td>
              </tr>
               <tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name3">Valor:</label>
                    <div class="col-sm-8">
                      <input type="text" name="expense_value" onKeyUp="mascaraMoeda(this, event)"  value="<?php echo isset($expense_info['expense_value']) ? number_format($expense_info['expense_value'], 2,',','.') : ''; ?>" placeholder="Informe o valor" id="expense_value" class="form-control">
                    </div>
                  </div>
                </td>
              </tr>
               <tr>
                  <td>
                    <div class="form-group required">
                      <label class="col-sm-2 control-label" for="input-name4">Meio de pagamento:</label>
                      <div class="col-sm-8">
                       <select name="payment_method_id" id="payment_method_id" class="form-control selectpicker select-report" data-live-search="true">
                      <?php foreach ( $payment_methods as $payment_method ){ ?>
                      <?php if ($payment_method['payment_method_id']) { ?>

                      <option value="<?php echo $payment_method['payment_method_id']; ?>" <?php echo (isset($expense_info['payment_method_id']) && $expense_info['payment_method_id']==$payment_method['payment_method_id']) ? 'selected' : '' ?>><?php echo $payment_method['name']; ?></option>

                    <?php } else { ?>

                       <option value="<?php echo $payment_method['payment_method_id']; ?>" ><?php echo $payment_method['name']; ?></option>
                      
                     <?php } ?>
						<?php } ?>
                      </div>
                    </div>
                  </td>
                </tr>
                 <tr>
                  <td>
                    <div class="form-group required">
                      <label class="col-sm-2 control-label" for="input-name5">Fornecedor:</label>
                      <div class="col-sm-8">
                       <select name="manufacturer_id" id="manufacturer_id" class="form-control">
                      <?php foreach ( $manufacturers as $manufacturer ){ ?>
                      <?php if ($manufacturer['manufacturer_id']) { ?>

                      <option value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php echo (isset($expense_info['manufacturer_id']) && $expense_info['manufacturer_id']==$manufacturer['manufacturer_id']) ? 'selected' : '' ?>><?php echo $manufacturer['name']; ?></option>

                    <?php } else { ?>

                       <option value="<?php echo $manufacturer['manufacturer_id']; ?>" ><?php echo $manufacturer['name']; ?></option>
                      
                     <?php } ?>
						<?php } ?>
                      </div>
                    </div>
                  </td>
                </tr>
              <!--  <tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name5">Responsável:</label> 
                    <div class="col-sm-8">
                      <input type="text" name="responsable_name" value="<?php echo isset($expense_info['responsable_name']) ? $expense_info['responsable_name'] : '' ?>" placeholder="Informe o responsavel" id="responsable_name" class="form-control">
                    </div>
                  </div>
                </td>
              </tr>-->
              <tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name6">Data:</label>
                     <div  class="col-sm-3 input-group date">
                     <input style="margin:0px 16px !important" type="text" readonly="readonly" name="date_purchase" value="<?php echo isset($expense_info['date_purchase']) ? $expense_info['date_purchase'] : '' ?>" placeholder="Data da despesa" data-date-format="YYYY-MM-DD" id="date_purchase" class="form-control" />
                      <span class="input-group-btn">
                      <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                      </span>
                  </div>
                  </div>
                </td>
              </tr>
              
                <tr>
                  <td>
                    <div class="form-group required">
                      <label class="col-sm-2 control-label" for="input-name7">Status:</label>
                      <div class="col-sm-8">
                        <select name="status" id="input-status" class="form-control">
                          <option value="1" <?php echo (isset($expense_info['active']) && $expense_info['active']==1) ? 'selected' : '' ?> >Inserido</option>
                          <option value="0" <?php echo (isset($expense_info['active']) && $expense_info['active']==0) ? 'selected' : '' ?> >Deletado</option>
                        </select>
                      </div>
                    </div>
                  </td>
                </tr>
                 <tr>
                  <td>
                    <div class="form-group required">
                      <label class="col-sm-2 control-label" for="input-name8">Loja:</label>
                      <div class="col-sm-8">
                       <select name="store_id" id="input-store_id" class="form-control">
                      <?php foreach ( $stores as $store ){ ?>
                      <?php if ($store['store_id']) { ?>

                      <option value="<?php echo $store['store_id']; ?>" <?php echo (isset($expense_info['store_id']) && $expense_info['store_id']==$store['store_id']) ? 'selected' : '' ?>><?php echo $store['name']; ?></option>

                    <?php } else { ?>

                       <option value="<?php echo $store['store_id']; ?>" ><?php echo $store['name']; ?></option>
                      
                     <?php } ?>
						<?php } ?>
                      </div>
                    </div>
                  </td>
                </tr>
                  <tr>
                  <td>
                    <div class="form-group required">
                      <label class="col-sm-2 control-label" for="input-name9">Centro de custo:</label>
                      <div class="col-sm-8">
                       <select name="cost_center_id" id="cost_center_id" class="form-control">
                      <?php foreach ( $costs as $cost ){ ?>
                      <?php if ($cost['cost_center_id'] ) { ?>

                      <option value="<?php echo $cost['cost_center_id']; ?>" <?php echo (isset($expense_info['cost_center_id']) && $expense_info['cost_center_id']==$cost['cost_center_id']) ? 'selected' : '' ?>><?php echo $cost['name']; ?></option>

                    <?php } else { ?>

                       <option value="<?php echo $cost['cost_center_id']; ?>" ><?php echo $cost['name']; ?></option>
                      
                     <?php } ?>
						<?php } ?>
                      </div>
                    </div>
                  </td>
                </tr>
            
            </table>

          </div>
        </form>
      </div>
    </div>
      <script type="text/javascript"><!--
$('.date').datetimepicker({
	language: '{{ datepicker }}',
	pickTime: false
});

      
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
  <script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
  <link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
  <script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>


<?php echo $footer; ?>
