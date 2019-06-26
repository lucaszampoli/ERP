<table class="table table-striped table-condensed" style="font-size:15pt !important">
    <thead>
    <tr>
        <th><i class="fa fa-credit-card" aria-hidden="true"></i> Bandeira</th>
        <th>% Porcentagem</th>
        <th><i class="fa fa-cog" aria-hidden="true"></i> Ação</th>
    </tr>
</thead>
<tbody>
  <?php foreach($ensigns as $ensign) { ?>
        <tr>
            <td><?php echo $ensign['name']; ?></td>
            <td><b><?php echo $ensign['ensign_value']; ?>%</b></td>
            <td><button type="button" data-ensign="<?php echo $ensign['ensign_id']; ?>" class="edit-ensign btn btn-info btn-lg" data-toggle="modal" data-target="#Modalstoreensignedit">
                        <i class="fa fa-pencil" aria-hidden="true"></i> Editar
                      </button>
            </td>
        </tr>
  <?php } ?>
</tbody>

</table>
<script>

$( document ).ready(function() {
	$('.edit-ensign').on('click', function()
			{
				var store_ensign_id = $(this).attr("data-ensign");
				
			  $(".modal-store-ensign").html('');
			  $(".modal-ensign").html('');
			    $.ajax({
			    		url: 'index.php?route=setting/store/getFormEditEnsign&token=<?php echo $token; ?>',
			    		dataType: 'html',
			    		data:{store_ensign_id:store_ensign_id },
			    		beforeSend: function() {
			    		},
			    		complete: function() {
			    		},
			    		success: function(form) {
			            $(".modal-store-ensign").html(form);
			    		},
			    		error: function(xhr, ajaxOptions, thrownError) {
			    			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			    		}
			    	});
			});

});


</script>