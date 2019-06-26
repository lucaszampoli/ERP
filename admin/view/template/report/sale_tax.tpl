<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?> </a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-bar-chart"></i> Relatório</h3>
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
        
        <!-- /#page-wrapper -->
       <div class="row">
       
        <div class="col-lg-6">
                        <div class="panel panel-default">
                        <div class="panel-heading"><h6>
                            <i class="fa fa-list fa-fw"></i> Previsto </h6>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                             <div class="col-lg-11">
                                 <div class="table-responsive">
                                 <table class="table">
												<thead>
													<tr>
														<th scope="col"><i class="fa fa-shopping-bag fa-fw"></i> Loja</th>
														<th scope="col"> Valor</th>
														<th scope="col"> Data do pagamento</th>
													</tr>
												</thead>
												<tbody>
												<?php
											
												foreach( $preview_invoices as $preview_invoice) { ?>
													<tr>
														<td style="font-size:10px"><?php echo $preview_invoice['loja']; ?></td>
														<td style="font-size:10px" > R$<?php echo number_format($preview_invoice['preview_invoice_value'], 2,',', '.'); ?></td>
														<td style="font-size:10px" ><?php echo $preview_invoice['date_payment']; ?></td>
												
													</tr>
													<?php }?>
													 <tr>
													<th scope="row">Total</th>
													<td><b> R$<?php echo number_format($total_preview_invoices, 2,',', '.');?></b></td>	
												</tr>
											    </tbody>
											 </table>
                                  
                            </div>
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    </div>
            </div>
       
       
        
                   
       
       <div class="col-lg-6">
                        <div class="panel panel-default">
                        <div class="panel-heading"><h6>
                            <i class="fa fa-list fa-fw"></i> Realizado </h6>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                             <div class="col-lg-11">
                                 <div class="table-responsive">
                                 <table class="table">
												<thead>
													<tr>
														<th scope="col"><i class="fa fa-shopping-bag fa-fw"></i> Loja</th>
														<th scope="col"> Valor</th>
														<th scope="col"> Data do pagamento</th>
														<th scope="col"> Data de recebimento</th>
													</tr>
												</thead>
												<tbody>
												<?php
											
												foreach( $invoices as $invoice) { ?>
													<tr>
														<td style="font-size:10px"><?php echo $invoice['loja']; ?></td>
														<td style="font-size:10px" > R$<?php echo number_format($invoice['invoice_value'], 2,',', '.'); ?></td>
														<td style="font-size:10px" ><?php echo $invoice['date_payment']; ?></td>
														<td style="font-size:10px" ><?php echo $invoice['date_receiving_payment']; ?></td>
													</tr>
													<?php }?>
													<tr>
													<th scope="row">Total</th>
													<td><b> R$<?php echo number_format($total_invoice, 2,',', '.');?></b></td>	
												</tr>
											    </tbody>
											 </table>
                                  
                            </div>
                            <!-- /.list-group -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    </div>
            </div>
         
         
         
    </div>    
        
        
         <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading"><h6>
                            <i class="fa fa-bar-chart-o fa-fw"></i> Gráfico total previsto vs realizado</h6>
           
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                         <div class="col-lg-15">
                          <div class="table-responsive">
                                 <table class="table">
                           <div id="chart" style="width:1100px"></div>
                           </table>
                           </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    </div>
                </div>
    </div>    
      </div>
    </div>
  </div>
</div>
<!-- Load c3.css -->
<link href="view/javascript/c3-charts/c3.css" rel="stylesheet">

<!-- Load d3.js and c3.js -->
<script src="view/javascript/c3-charts/d3.js"></script>
<script src="view/javascript/c3-charts/c3.js"></script>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=report/sale_tax&token=<?php echo $token; ?>';

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
<script>

var chart = c3.generate({
    data: {
        columns: [
              <?php echo $json_customers; ?>,
        	 <?php echo $json_values; ?>,
        			
        					 
        	 
        ],
        axes:{
        	$: 'y'
        },
        labels: true
    },

    axis : {
        x : {
            type : 'category',
            categories : <?php echo $json_weeks; ?>

        },
    y2: {
    	show:false
    }
    },
    tooltip:{
    	format:{
    		
    		value: function(value) {
                return d3.format(",.2f")(value)
            }
    	}
    	
    }
   
});


</script>
<?php echo $footer; ?>