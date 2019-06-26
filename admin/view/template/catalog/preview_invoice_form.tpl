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
                      <label class="col-sm-2 control-label" for="input-name8">Loja:</label>
                      <div class="col-sm-8">
                       <select name="store_id" id="input-store_id" class="form-control">
                      <?php foreach ( $stores as $store ){ ?>
                      <?php if ($store['store_id']) { ?>

                      <option value="<?php echo $store['store_id']; ?>" <?php echo (isset($preview_invoice_info['store_id']) && $preview_invoice_info['store_id']==$store['store_id']) ? 'selected' : '' ?>><?php echo $store['name']; ?></option>

                    <?php } else { ?>

                       <option value="<?php echo $store['store_id']; ?>" ><?php echo $store['name']; ?></option>
                      
                     <?php } ?>
						<?php } ?>
                      </div>
                    </div>
                  </td>
                </tr>      
              <tr>
             <input type="hidden" name="preview_invoice_id" value="<?php echo ($preview_invoice_info['preview_invoice_id']) ? $preview_invoice_info['preview_invoice_id'] : '' ?>"  id="preview_invoice_id" class="form-control">
              </tr>
              <!-- <tr>
                  <td>
                    <div class="form-group required">
                      <label class="col-sm-2 control-label" for="input-name8">Meio de pagamento:</label>
                      <div class="col-sm-8 date-to-days">
                       <select name="payment_method_id" id="input-payment_method_id" class="form-control">
                      <?php foreach ( $type_to_payments as $type_to_payment ){ ?>
                      <?php if ($type_to_payment['payment_method_id']) { ?>

                      <option data-days="<?php echo (int)$type_to_payment['days_to_payment']; ?>" value="<?php echo $type_to_payment['payment_method_id']; ?>" <?php echo (isset($preview_invoice_info['payment_method_id']) && $preview_invoice_info['payment_method_id'] == $type_to_payment['payment_method_id']) ? 'selected' : '' ?>><?php echo $type_to_payment['name']; ?></option>

                    <?php } else { ?>

                       <option value="<?php echo $type_to_payment['store_id']; ?>" ><?php echo $type_to_payment['name']; ?></option>
                      
                     <?php } ?>
						<?php } ?>
                      </div>
                    </div>
                  </td>
                </tr>   -->    
              <tr>
               <tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name3">Valor:</label>
                    <div class="col-sm-8">
                      <input type="text" name="preview_invoice_value" onKeyUp="mascaraMoeda(this, event)" value="<?php echo isset($preview_invoice_info['preview_invoice_value']) ? number_format($preview_invoice_info['preview_invoice_value'], 2,',','.') : ''; ?>" placeholder="Informe o valor" id="preview_invoice_value" class="form-control">
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name6">Data:</label>
                     <div  class="col-sm-3 input-group date date-value">
                     <input style="margin:0px 16px !important" type="text" readonly="readonly" name="date_payment" value="<?php echo isset($preview_invoice_info['date_payment']) ? $preview_invoice_info['date_payment'] : '' ?>" placeholder="Data do Faturamento" data-date-format="YYYY-MM-DD" id="date_payment" class="date-to-invoice form-control" />
                      <span class="input-group-btn">
                      <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                      </span> 
                  </div>
                </td>
              </tr>
                  <!--<tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name3">Clientes Atentidos:</label>
                    <div class="col-sm-8">
                      <input type="number" name="customer_attended" value="<?php echo isset($preview_invoice_info['customer_attended']) ? $preview_invoice_info['customer_attended'] : ''; ?>" placeholder="Informe a quantidade de clientes atendidos" id="customer_attended" class="form-control">
                    </div>
                  </div>
                </td>
              </tr>-->
                      
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
    <script type="text/javascript" src="view/javascript/moment.js"></script>

<?php echo $footer; ?>
