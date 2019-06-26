<div class="edit" style="width:87%; margin:0px 25px !important ">
<div class="form-group">
  <label class="col-sm-2 control-label" for="input-country">Sócio:</label>
  <div class="col-sm-10">
    <select name="user" id="user" class="form-control">
      <?php foreach($users as $user){ ?>
        <option  value="<?php echo $user['user_id']; ?>" <?php echo (isset($partner['user_id']) && $partner['user_id']==$user['user_id']) ? 'selected' : '' ?>><?php echo $user['firstname']; ?> <?php echo $user['lastname']; ?></option>
    <?php  } ?>
    </select>
  </div>
</div>
<div class="form-group">
  <label class="col-sm-2 control-label" for="input-country">Tipo:</label>
  <div class="col-sm-10">
    <select name="group" id="group" class="form-control">
      <?php foreach($groups as $group){ ?>
        <option value="<?php echo $group['user_group_id']; ?>" <?php echo (isset($partner['user_group_id']) && $partner['user_group_id']==$group['user_group_id']) ? 'selected' : '' ?>><?php echo $group['name']; ?></option>
    <?php  } ?>
    </select>
  </div>
</div>

<div class="form-group">
  <label class="col-sm-2 control-label" for="input-email">Investimento:</label>
  <div class="col-sm-10">
    <input type="text" id="investiment" onKeyUp="mascaraMoeda(this, event)" value="<?php echo isset($partner['investiment']) ? number_format($partner['investiment'], 2,',','.') : '' ?>" placeholder="Valor investido"  class="form-control" />
  </div>
</div>

<div class="form-group">
  <label class="col-sm-2 control-label" for="input12">Porcentagem:</label>
  <div class="col-sm-10">
    <input type="text" id="percentage" onKeyUp="mascaraMoeda(this, event)" value="<?php echo isset($partner['percentage']) ? number_format($partner['percentage'], 2,',','.') : '' ?>" placeholder="Porcentagem"  class="form-control" />
  </div>
</div>
<input type="hidden" name="store_partner_id" value="<?php echo ($partner['store_partner_id']) ? $partner['store_partner_id'] : '' ?>"  id="store_partner_id" class="form-control">
 <input type="hidden" name="store_id" value="<?php echo ($partner['store_id']) ? $partner['store_id'] : '' ?>"  id="store_id" class="form-control">
 
 </div>
  
<script type="text/javascript"><!--
$('#edit-partner').on('click', function() {

	  var store_partner_id = $('#store_partner_id').val();
	  var store = $('#store_id').val();
	  var user = $('#user').val();
	  var group = $('#group').val();
	  var investiment = $('#investiment').val();
	  var percentage = $('#percentage').val();

	  console.log(store_partner_id, store, user, group, investiment, percentage);

	  $.ajax({
	      url: 'index.php?route=setting/store/editPartner&token=<?php echo $token; ?>',
	      dataType: 'json',
	      data:{ store_partner_id:store_partner_id, store:store, user:user, group:group, investiment:investiment, percentage:percentage },
	      beforeSend: function() {
	      },
	      complete: function() {
	      },
	      success: function(id) {

	        if(id > 0)
	        {
	        	$( "#close-edit-modal" ).trigger( "click" );
	        	refreshPartnerList();
	        	
	        }
	        else
	        {
	          $("#modal-edit-error").html("Algo de errado ao editar o sócio!");
	          $(".modal-edit-alert").removeClass("hide");

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