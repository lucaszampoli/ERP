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
     <!-- /#page-wrapper --><br /><br /><br /><br /><br /><br /><br /><br /><br />
       <div class="row">
       <div class="col-lg-12">
       <div align="center">
       <h1 style="align:center !important; color:#1e91cf !important">Bem-vindo(a) </h1><h1><b><?php echo isset($user['firstname']) && count($user['firstname'] > 0) ? $user['firstname'] : '';?>
                                                                                              <?php echo isset($user['lastname']) && count($user['lastname'] > 0) ? $user['lastname'] : '';?></b></h1>
                                                                                              <h5><?php if(isset($last_access) && count($last_access)>0) {?> Seu último acesso foi em &nbsp;<?php }?>
                                                                                                   <i style="font-size:10pt" class="fa fa-calendar"></i> <?php echo isset($last_access['date_added_format']) && count($last_access['date_added_format'] > 0) ? $last_access['date_added_format'] : '';?>
																								   <i style="font-size:12pt" class="fa fa-clock-o"></i> <?php echo isset($last_access['hour_date_added']) && count($last_access['hour_date_added'] > 0) ? $last_access['hour_date_added'] : '';?>
                                                                                              </h5>
       </div>
       </div>
       </div>
</div>
<?php echo $footer; ?>
