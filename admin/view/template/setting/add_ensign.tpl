<div class="add-ensign" style="width:87%; margin:0px 25px !important ">
<div class="form-group">
  <label class="col-sm-2 control-label" for="input-country">Bandeira:</label>
  <div class="col-sm-10">
    <select name="payment_method_id" id="payment_method_id" class="form-control">
      <?php foreach($payment_methods as $payment_method){ ?>
        <option  value="<?php echo $payment_method['payment_method_id']; ?>" > <?php echo $payment_method['name']; ?></option>
    <?php  } ?>
    </select>
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="input12">Porcentagem:</label>
  <div class="col-sm-10">
    <input type="text" id="ensign_value" onKeyUp="mascaraMoeda(this, event)" value="" placeholder="Porcentagem"  class="form-control" />
  </div>
</div>

</div>

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