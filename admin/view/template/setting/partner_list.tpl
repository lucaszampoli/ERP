<table class="table table-striped table-condensed" style="font-size:15pt !important">
    <thead>
    <tr>
        <th><i class="fa fa-users" aria-hidden="true"></i> Nome</th>
        <th><i class="fa fa-object-group" aria-hidden="true"></i> Tipo</th>
        <th><i class="fa fa-money" aria-hidden="true"></i> Investimento</th>
        <th>% Investimento</th>
        <th><i class="fa fa-cog" aria-hidden="true"></i> Ação</th>
    </tr>
</thead>
<tbody>
  <?php foreach($partners as $partner) { ?>

        <tr>
            <td><?php echo $partner['firstname']; ?> <?php echo $partner['lastname']; ?></td>
            <td><?php echo $partner['group_name']; ?></td>
            <td><?php echo $partner['investiment']; ?></td>
            <td><b><?php echo $partner['percentage']; ?>%</b></td>
            <td><button type="button" data-partner="<?php echo $partner['store_partner_id']; ?>" class="edit_partner btn btn-info btn-lg" data-toggle="modal" data-target="#Modaledit">
                        <i class="fa fa-user" aria-hidden="true"></i> Editar
                      </button>
            </td>
        </tr>
  <?php } ?>
</tbody>

</table>


<script>

$( document ).ready(function() {
  $('.edit_partner').on('click', function()
  	{
  		var store_partner_id = $(this).attr("data-partner");

  	  $(".modal-body").html('');
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
});


</script>