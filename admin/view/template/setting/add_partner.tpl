<div class="form-group">
  <label class="col-sm-2 control-label" for="input-country">Sócio:</label>
  <div class="col-sm-10">
    <select name="user" id="user" class="form-control">
      <?php foreach($users as $user){ ?>
        <option  value="<?php echo $user['user_id']; ?>"><?php echo $user['firstname']; ?> <?php echo $user['lastname']; ?></option>
    <?php  } ?>
    </select>
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="input-country">Tipo:</label>
  <div class="col-sm-10">
    <select name="group" id="group" class="form-control">
      <?php foreach($groups as $group){ ?>
        <option value="<?php echo $group['user_group_id']; ?>"><?php echo $group['name']; ?></option>
    <?php  } ?>
    </select>
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="input-email">Investimento:</label>
  <div class="col-sm-10">
    <input type="text" id="investiment" onKeyUp="mascaraMoeda(this, event)" value="" placeholder="Valor investido"  class="form-control" />
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="input12">Porcentagem:</label>
  <div class="col-sm-10">
    <input type="text" id="percentage" onKeyUp="mascaraMoeda(this, event)" value="" placeholder="Porcentagem"  class="form-control" />
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
