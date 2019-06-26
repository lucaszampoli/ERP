<div class="form-group">
  <label class="col-sm-2 control-label" for="input-country">Data do pagamento:</label>

    <div  class="col-sm-6 input-group date">
                        <input style="margin:0px 16px !important" type="text" readonly="readonly" name="date_payment" value="<?php echo (isset($expense_info['date_payment'])&& $expense_info['date_payment'] <>'0000-00-00') ? $expense_info['date_payment'] : '' ?>" placeholder="Data do pagamento" data-date-format="YYYY-MM-DD" id="date_payment" class="form-control" />
                      <span class="input-group-btn">
                      <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                      </span>
                  
  </div>
  
</div>

 <input type="hidden" name="expense_id" value="<?php echo ($expense_info['expense_id']) ? $expense_info['expense_id'] : '' ?>"  id="expense_id" class="form-control">
 

      <script type="text/javascript"><!--
$('.date').datetimepicker({
	language: '{{ datepicker }}',
	pickTime: false
});

      
//--></script>
