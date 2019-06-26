<div class="edit-ensign" style="width:87%; margin:0px 25px !important ">
<div class="form-group">
  <label class="col-sm-2 control-label" for="input-country">Bandeira:</label>
  <div class="col-sm-10">
    <select name="payment_method_id" id="payment_method_id" class="form-control">
      <?php foreach($payment_methods as $payment_method){ ?>
        <option  value="<?php echo $payment_method['payment_method_id']; ?>" <?php echo (isset($ensign['payment_method_id']) && $ensign['payment_method_id']==$payment_method['payment_method_id']) ? 'selected' : '' ?> > <?php echo $payment_method['name']; ?></option>
    <?php  } ?>
    </select>
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="input12">Porcentagem:</label>
  <div class="col-sm-10">
    <input type="text" id="ensign_value" onKeyUp="mascaraMoeda(this, event)" value="<?php echo ($ensign['ensign_value']) ? number_format($ensign['ensign_value'], 2,',','.') : '' ?>" placeholder="Porcentagem"  class="form-control" />
  </div>
</div>



<input type="hidden" name="store_ensign_id" value="<?php echo ($ensign['ensign_id']) ? $ensign['ensign_id'] : '' ?>"  id="store_ensign_id" class="form-control">
 <input type="hidden" name="store_id" value="<?php echo ($ensign['store_id']) ? $ensign['store_id'] : '' ?>"  id="store_id" class="form-control">
 
 </div>
  
<script type="text/javascript"><!--
$('#edit-ensign').on('click', function() {

	  var store_ensign_id = $('#store_ensign_id').val();
	  var store = $('#store_id').val();
	  var payment_method_id = $('#payment_method_id').val();
	  var ensign_value = $('#ensign_value').val();

	  console.log(store_ensign_id, store, payment_method_id, ensign_value);

	  $.ajax({
	      url: 'index.php?route=setting/store/editEnsign&token=<?php echo $token; ?>',
	      dataType: 'json',
	      data:{ store_ensign_id:store_ensign_id, store:store, payment_method_id:payment_method_id, ensign_value:ensign_value },
	      beforeSend: function() {
	      },
	      complete: function() {
	      },
	      success: function(id) {

	        if(id > 0)
	        {
	        	$( "#close-ensign-edit-modal" ).trigger( "click" );
	        	refreshEnsignList();
	        	
	        }
	        else
	        {
	          $("#modal-edit-ensign-error").html("Algo de errado ao editar a bandeira!");
	          $(".modal-edit-ensign-alert").removeClass("hide");

	        }
	      },
	      error: function(xhr, ajaxOptions, thrownError) {
	        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	      }
	    });
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