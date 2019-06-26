<?php
class ModelCatalogInvoice extends Model {
	public function addInvoice($data)
  {
  	 $invoice_value = $this->modifyMask($data);
  	 
		$this->db->query("INSERT INTO " . DB_PREFIX . "invoice
                      SET
                         store_id = '".$data['store_id']."',
                         user_id = '" . (int)$this->user->getId() . "',
                         invoice_description = '".$data['invoice_description']."',
                         invoice_value = '". $invoice_value ."',
                         date_payment = '".$data['date_payment']."',
                         active = '".$data['status']."',
                         customer_attended = '".$data['customer_attended']."',
                         date_receiving_payment = '".$data['date_receiving_payment']."',
                         payment_method_id = '".$data['payment_method_id']."'                         

                      ");

		return $this->db->getLastId();
	}

	public function editInvoice($invoice_id, $data)
  { 
  	$invoice_value = $this->modifyMask($data);
  	
    $this->db->query("UPDATE " . DB_PREFIX . "invoice
                      SET
                         store_id = '".$data['store_id']."',
                         user_id = '" . (int)$this->user->getId() . "',
                         invoice_description = '".$data['invoice_description']."',
                         invoice_value = '". $invoice_value ."',
                         date_payment = '".$data['date_payment']."',
                         active = '".$data['status']."',
                         customer_attended = '".$data['customer_attended']."',
                         date_receiving_payment = '".$data['date_receiving_payment']."',
                         payment_method_id = '".$data['payment_method_id']."'    
                      WHERE invoice_id = '".$invoice_id."'
                      ");

    
	}

	public function getInvoice($invoice_id) {
		$query = $this->db->query("SELECT i.* , DATE(i.date_payment) AS date_payment
			                        FROM invoice i
	                                WHERE invoice_id ='" . (int)$invoice_id . "'");
		return $query->row;
	}

	public function getInvoices($data = array())
  {
		$sql = "SELECT * FROM invoice WHERE 1";


		if (!empty($data['filter_customer'])) {
			$sql .= " AND store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(date_receiving_payment) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(date_receiving_payment) = '" . $this->db->escape($data['filter_year']) . "'";
		}
		
		$sort_data = array(
			'invoice_value',
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
		}

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

	public function getTotalInvoice($data = array()) {
		$sql = "SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "invoice WHERE 1";

	    if (!empty($data['filter_customer'])) {
			$sql .= " AND store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(date_receiving_payment) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(date_receiving_payment) = '" . $this->db->escape($data['filter_year']) . "'";
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
	
	public function getInvoiceStore($invoice_id) {
		$query = $this->db->query("SELECT * FROM invoice i 
									JOIN store s on i.store_id = s.store_id
									Where i.invoice_id = '" . (int)$invoice_id . "'");

		return $query->row;
	}
	
   public function getMethodPayments() {
		$query = $this->db->query("SELECT * FROM payment_method");

		return $query->rows;
	}
   
	public function modifyMask($data)
    {
  	        $invoice_value = $data['invoice_value'];
            $invoice_value = trim($invoice_value);
			$invoice_value = str_replace(".", "", $invoice_value);
			$invoice_value = str_replace(",", ".", $invoice_value);
		
			return $invoice_value;
			
	}

	public function getStores()
	{

		$query = $this->db->query("SELECT * FROM store");

		return $query->rows ;

	}
}
