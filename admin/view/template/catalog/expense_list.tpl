<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a> <a href="<?php echo $repair; ?>" data-toggle="tooltip" title="<?php echo $button_rebuild; ?>" class="btn btn-default"><i class="fa fa-refresh"></i></a>
        <!-- button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-category').submit() : false;"><i class="fa fa-trash-o"></i></button-->
      </div>
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
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
       <div class="well">
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
		 <label class="control-label" for="input-month"> Mês</label>
					<select name="filter_month" id="input-month select-report" class="form-control">
						<option <?php echo ($filter_month== '01') ? 'selected' : ''; ?> value="01" >Janeiro</option>
						<option <?php echo ($filter_month== '02') ? 'selected' : ''; ?> value="02" >Fevereiro</option>
						<option <?php echo ($filter_month== '03') ? 'selected' : ''; ?> value="03" >Março</option>
						<option <?php echo ($filter_month== '04') ? 'selected' : ''; ?> value="04" >Abril</option>
						<option <?php echo ($filter_month== '05') ? 'selected' : ''; ?> value="05" >Maio</option>
						<option <?php echo ($filter_month== '06') ? 'selected' : ''; ?> value="06" >Junho</option>
						<option <?php echo ($filter_month== '07') ? 'selected' : ''; ?> value="07" >Julho</option>
						<option <?php echo ($filter_month== '08') ? 'selected' : ''; ?> value="08" >Agosto</option>
						<option <?php echo ($filter_month== '09') ? 'selected' : ''; ?> value="09" >Setembro</option>
						<option <?php echo ($filter_month== '10') ? 'selected' : ''; ?> value="10" >Outubro</option>
						<option <?php echo ($filter_month== '11') ? 'selected' : ''; ?> value="11" >Novembro</option>
						<option <?php echo ($filter_month== '12') ? 'selected' : ''; ?> value="12" >Dezembro</option>
					</select>
			</div>
			     	<div class="form-group">
					  <label class="control-label" for="input-year"> Ano</label>
			            <select name="filter_year" id="input-year" class="form-control selectpicker select-report" data-live-search="true">
						<option <?php echo ($filter_year== '2018') ? 'selected' : ''; ?> value="2018" >2018</option>
						<option <?php echo ($filter_year== '2019') ? 'selected' : ''; ?> value="2019" >2019</option>
						<option <?php echo ($filter_year== '2020') ? 'selected' : ''; ?> value="2020" >2020</option>
						<option <?php echo ($filter_year== '2021') ? 'selected' : ''; ?> value="2021" >2021</option>
						<option <?php echo ($filter_year== '2022') ? 'selected' : ''; ?> value="2022" >2022</option>
						<option <?php echo ($filter_year== '2023') ? 'selected' : ''; ?> value="2023" >2023</option>
						<option <?php echo ($filter_year== '2024') ? 'selected' : ''; ?> value="2024" >2024</option>
						<option <?php echo ($filter_year== '2025') ? 'selected' : ''; ?> value="2025" >2025</option>
						<option <?php echo ($filter_year== '2026') ? 'selected' : ''; ?> value="2026" >2026</option>
						<option <?php echo ($filter_year== '2027') ? 'selected' : ''; ?> value="2027" >2027</option>
						<option <?php echo ($filter_year== '2028') ? 'selected' : ''; ?> value="2028" >2028</option>
						<option <?php echo ($filter_year== '2029') ? 'selected' : ''; ?> value="2029" >2029</option>
						<option <?php echo ($filter_year== '2030') ? 'selected' : ''; ?> value="2030" >2030</option>
						</select>
					 </div>
			</div>
                <div class="col-sm-6">
                   <div class="form-group">
		               <label class="control-label" for="input-month"> Loja</label>
			           <select name="filter_customer" id="input-customer" class="form-control selectpicker select-report" data-live-search="true">
                       <option value="0">Todas</option>

                       <?php foreach ( $stores as $store){ ?>
                       <?php if ($store['store_id'] == $filter_customer) { ?>

                       <option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>

                       <?php } else { ?>

                       <option value="<?php echo $store['store_id']; ?>" ><?php echo $store['name']; ?></option>

                       <?php } ?>
					   <?php } ?>
						</select>
						</div>

					 <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-filter"></i> Filtrar</button>
            </div>
      </div>
      </div>   
      
      
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-category">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td class="text-left"><?php if ($sort == 'expense_description') { ?>
                    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                    <?php } ?></td>
                   <!-- <td class="text-right"><?php if ($sort == 'sort_order') { ?>
                    <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $language->get('active') ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_sort_order; ?>"><?php echo $language->get('Status'); ?></a>
                    <?php } ?></td> -->
                    <td class="text-left">Loja</td>
                    <td class="text-left">Centro de custo</td>
                    <td class="text-left">Data da despesa</td>
                    <td class="text-right">Valor</td>
                    <td class="text-right">Pago em</td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if (isset($expenses) && count($expenses)>0) { ?>
                <?php foreach ($expenses as $expense) { ?>
                <tr>
                  <td class="text-center"><?php if (in_array($expense['expense_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $category['category_id']; ?>" />
                    <?php } ?></td>
                  <td class="text-left"><?php echo $expense['expense_description']; ?></td>
                 <!--   <td class="text-right"><?php echo ( $expense['active'] == 1 ) ? 'Ativo' : 'Desabilitado'; ?></td>-->
                   <td class="text-left"><?php echo $expense['loja']; ?></td>
                   <td class="text-left"><?php echo $expense['cost_center']; ?></td>
                   <td class="text-left"><?php echo date("d/m/Y",strtotime($expense['date_purchase'])); ?></td>
                   <td class="text-right"><?php echo  number_format($expense['expense_value'], 2,',','.');?></td>
                     <td class="text-right" id="status-<?php echo $expense['expense_id']; ?>"><?php echo ($expense['paid'] =='S')? date("d/m/Y",strtotime($expense['date_payment'])) : '<b>Não Pago</b>'; ?></td> 
                  <td class="text-right">
                  <?php $hide_buttom = '';
                  if ($expense['paid'] == 'S')  {
                   $hide_buttom = 'hide';
	                     }?>
                  <a data-expense="<?php echo $expense['expense_id']; ?>"  data-toggle="modal" data-target="#myModal" title="Pagamento" class="btn btn-success save_payment  <?php echo $hide_buttom ;?>"><i class="fa fa-money"></i></a>
                 
                  <a href="<?php echo $expense['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Modal -->
 <div id="myModal" class="modal fade" role="dialog">
                        <div class="modal-dialog">
                          <!-- Modal content-->
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title"><i class="fa fa-user" aria-hidden="true"></i> Adicionar Data de Pagamento</h4>
                            </div>
                              <div class="modal-body">


                              </div>
                              <div class="alert alert-danger modal-alert hide"><i class="fa fa-exclamation-circle"></i>
                                 <span id="modal-error"></span>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                              </div>
                              <div class="modal-footer">
                                <button type="button" id="close-modal" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" id="save-paid" class="btn btn-success">Adicionar</button>
                              </div>
                              
                          </div>
<script type="text/javascript"><!--
$('.save_payment').on('click', function()
{
	var expense_id = $(this).attr("data-expense");
  $(".modal-body").html('');

    $.ajax({
    		url: 'index.php?route=catalog/expense/getFormAddPayment&&token=<?php echo $token; ?>',
    		dataType: 'html',
    		data:{ expense_id:expense_id},
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

$('#save-paid').on('click', function() {
 var expense_id = $('#expense_id').val(); ;
 var date_payment = $('#date_payment').val();
 var status = $("#status-"+expense_id).attr('data-status') ;
 var expense = $(this).attr("data-expense");
  $.ajax({
      url: 'index.php?route=catalog/expense/addPaid&&token=<?php echo $token; ?>',
      dataType: 'json',
      data:{expense_id:expense_id, date_payment:date_payment },
      beforeSend: function() {
      },
      complete: function() {
      },
      success: function(id) {

        if(id > 0)
        {
        	$("#status-"+expense_id).html("Pago");
            $(".save_payment[data-expense='"+expense_id+"']").hide();
            $( "#close-modal" ).trigger( "click" );
        }
        else
        {
          $("#modal-error").html("Algo de errado ao salvar o pagamento!");
          $(".modal-alert").removeClass("hide");

        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
});



//--></script>
 <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=catalog/expense&token=<?php echo $token; ?>';

	var filter_customer = $('select[name=\'filter_customer\']').val();

	if (filter_customer) {
		url += '&filter_customer=' + encodeURIComponent(filter_customer);
	}
	
	var filter_month = $('select[name=\'filter_month\']').val();
	
	if (filter_month) {
		url += '&filter_month=' + encodeURIComponent(filter_month);
	}
	
	var filter_year = $('select[name=\'filter_year\']').val();
	
	if (filter_year != 0) {
		url += '&filter_year=' + encodeURIComponent(filter_year);
	}	

	location = url;
});
//--></script> 
<style>
.text-area
{
width:99% !important;
height:50px !important;
}
.input-report
{
  height:30px !important;
}

.select-report
{
  z-index: 0 !important;
}

</style>

<?php echo $footer; ?>
