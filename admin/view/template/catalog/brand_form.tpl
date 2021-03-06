<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-brand" class="form-horizontal">
          <div class="form-group">
            <table width="100%">
              <tr>
                <td>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name2">Nome:</label>
                    <div class="col-sm-8">
                      <input type="text" name="name" value="<?php echo isset($brand_info['name']) ? $brand_info['name'] : '' ?>" placeholder="Digite o nome da marca" id="brand_name" class="form-control">
                      <input type="hidden" name="brand_id" value="<?php echo ($brand_info['brand_id']) ? $brand_info['brand_id'] : '' ?>"  id="brand_id" class="form-control">
                    </div>
                  </div>
                </td>
              <tr>
                <tr>
                  <td>
                    <div class="form-group required">
                      <label class="col-sm-2 control-label" for="input-name2">Status:</label>
                      <div class="col-sm-8">
                        <select name="status" id="input-status" class="form-control">
                          <option value="1" <?php echo (isset($brand_info['active']) && $brand_info['active']==1) ? 'selected' : '' ?> >Habilitado</option>
                          <option value="0" <?php echo (isset($brand_info['active']) && $brand_info['active']==0) ? 'selected' : '' ?> >Desabilitado</option>
                        </select>
                      </div>
                    </div>
                  </td>
                <tr>
            </table>

          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
  <link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
  <script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>


<?php echo $footer; ?>
