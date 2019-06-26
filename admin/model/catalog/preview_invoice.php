<?php
class ModelCatalogPreviewInvoice extends Model {
	public function addPreviewInvoice($data)
  {
  	$preview_invoice_value = $this->modifyMask($data);
  	
		$this->db->query("INSERT INTO " . DB_PREFIX . "preview_invoice
                      SET
                         store_id = '".$data['store_id']."',
                         user_id = '" . (int)$this->user->getId() . "',
                         preview_invoice_description = '".$data['preview_invoice_description']."',
                         preview_invoice_value = '". $preview_invoice_value ."',
                         date_payment = '".$data['date_payment']."',
                         active = '".$data['status']."',
                         customer_attended = '".$data['customer_attended']."',
                         date_receiving_payment = '".$data['date_receiving_payment']."',
                         payment_method_id = '".$data['payment_method_id']."'                         

                      ");

		return $this->db->getLastId();
	}

	public function editPreviewInvoice($preview_invoice_id, $data)
  {
  	$preview_invoice_value = $this->modifyMask($data);
  	
    $this->db->query("UPDATE " . DB_PREFIX . "preview_invoice
                      SET
                         store_id = '".$data['store_id']."',
                         user_id = '" . (int)$this->user->getId() . "',
                         preview_invoice_description = '".$data['invoice_description']."',
                         preview_invoice_value = '". $preview_invoice_value ."',
                         date_payment = '".$data['date_payment']."',
                         active = '".$data['status']."',
                         customer_attended = '".$data['customer_attended']."',
                         date_receiving_payment = '".$data['date_receiving_payment']."',
                         payment_method_id = '".$data['payment_method_id']."'    
                      WHERE preview_invoice_id = '".$preview_invoice_id."'
                      ");

    
	}

	public function getPreviewInvoice($preview_invoice_id) {
		$query = $this->db->query("SELECT pi.* , DATE(pi.date_payment) AS date_payment
			                        FROM preview_invoice pi
	                                WHERE pi.preview_invoice_id ='" . (int)$preview_invoice_id . "'");
		return $query->row;
	}

	public function getPreviewInvoices($data = array())
  {
		$sql = "SELECT * FROM preview_invoice WHERE 1";
		
        if (!empty($data['filter_customer'])) {
			$sql .= " AND store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(date_payment) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(date_payment) = '" . $this->db->escape($data['filter_year']) . "'";
		}

		/*$sort_data = array(
			'preview_invoice_value',
			'active'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY sort_order";
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		} */
        $sql .= " ORDER BY date_payment DESC";
        
		

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalPreviewInvoice($data = array()) {
		$sql = "SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "preview_invoice WHERE 1";

	   if (!empty($data['filter_customer'])) {
			$sql .= " AND store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(date_payment) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(date_payment) = '" . $this->db->escape($data['filter_year']) . "'";
		}
		
		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}

	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "category_to_layout
                                WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
	
	public function getPreviewInvoiceStore($preview_invoice_id) {
		$query = $this->db->query("SELECT * FROM preview_invoice pi 
									JOIN store s on s.store_id = pi.store_id
									Where pi.preview_invoice_id = '" . (int)$preview_invoice_id . "'");

		return $query->row;
	}
	
   public function getMethodPayments() {
		$query = $this->db->query("SELECT * FROM payment_method");

		return $query->rows;
	}

	public function modifyMask($data)
    {
  	        $preview_invoice_value = $data['preview_invoice_value'];
            $preview_invoice_value = trim($preview_invoice_value);
			$preview_invoice_value = str_replace(".", "", $preview_invoice_value);
			$preview_invoice_value = str_replace(",", ".", $preview_invoice_value);
		
			return $preview_invoice_value;
			
	}

	public function getStores()
	{

		$query = $this->db->query("SELECT * FROM store");

		return $query->rows ;

	}
}
