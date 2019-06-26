<?php
class ModelCatalogExpense extends Model {
	public function addExpense($data)
  {
  	    $expense_value = $this->modifyMask($data);
  	    
		$this->db->query("INSERT INTO " . DB_PREFIX . "expense
                      SET
                         expense_description = '".$data['expense_description']."',
                         expense_value = '". $expense_value ."',
                         payment_method_id = '".$data['payment_method_id']."',
                         manufacturer_id = '".$data['manufacturer_id']."',
                         date_purchase = '".$data['date_purchase']."',
                         active = '".$data['status']."',
                         store_id = '".$data['store_id']."',
                         cost_center_id = '".$data['cost_center_id']."',
                         user_id = '" . (int)$this->user->getId() . "'

                      ");

		return $this->db->getLastId();
	}

	public function editExpense($expense_id, $data)
  {
  	 $expense_value = $this->modifyMask($data);
  	 
    $this->db->query("UPDATE " . DB_PREFIX . "expense
                      SET
                         expense_description = '".$data['expense_description']."',
                         expense_value = '". $expense_value ."',
                         payment_method_id = '".$data['payment_method_id']."',
                         manufacturer_id = '".$data['manufacturer_id']."',
                         date_purchase = '".$data['date_purchase']."',
                         active = '".$data['status']."',
                         store_id = '".$data['store_id']."',
                         cost_center_id = '".$data['cost_center_id']."',
                         user_id = '" . (int)$this->user->getId() . "'
                      WHERE expense_id = '".$expense_id."'
                      ");

    
	}

	public function getExpense($expense_id) {
		$query = $this->db->query("SELECT e.* , DATE(e.date_purchase) AS date_purchase, DATE(e.date_payment) AS date_payment
			                        FROM expense e
	                                WHERE expense_id ='" . (int)$expense_id . "'");
		return $query->row;
	}

	public function getExpenses($data = array())
  {
		$sql = "SELECT * FROM expense WHERE 1";
        
        if (!empty($data['filter_customer'])) {
			$sql .= " AND store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(date_purchase) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(date_purchase) = '" . $this->db->escape($data['filter_year']) . "'";
		}
		
		$sort_data = array(
			'expense_description',
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

	public function getTotalExpense($data = array()) {
		$sql = "SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "expense WHERE 1";
	    
		if (!empty($data['filter_customer'])) {
			$sql .= " AND store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(date_purchase) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(date_purchase) = '" . $this->db->escape($data['filter_year']) . "'";
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
	
	public function getCosts($data = array())
	  {
			$sql = "SELECT * FROM cost_center WHERE active = 1 ";
	
			$query = $this->db->query($sql);
	
			return $query->rows;
		}
	
	public function getPaymentMethods($data = array())
	  {
			$sql = "SELECT * FROM payment_method WHERE active = 1 ";
	
			$query = $this->db->query($sql);
	
			return $query->rows;
		}

	public function getExpenseStore($expense_id) {
		$query = $this->db->query("SELECT * FROM expense e 
									JOIN store s on e.store_id = s.store_id
									Where e.expense_id = '" . (int)$expense_id . "'");

		return $query->row;
	}
	
	public function getExpenseCostCenter($expense_id) {
		$query = $this->db->query("SELECT * FROM expense e 
									JOIN cost_center cc on e.cost_center_id = cc.cost_center_id
									Where e.expense_id = '" . (int)$expense_id . "'");

		return $query->row;
	}

	public function addPaid($data)
  {
		$this->db->query("UPDATE " . DB_PREFIX . "expense
                      SET
                        paid = 'S',
						date_payment = '" . $this->db->escape($data['date_payment']) . "'
                       Where expense_id =  '" . $this->db->escape($data['expense_id']) . "'
                       ");

		$expense_id = $this->db->countAffected();

		return $expense_id;
	}
	
	public function modifyMask($data)
  {
  	        $expense_value = $data['expense_value'];
            $expense_value = trim($expense_value);
			$expense_value = str_replace(".", "", $expense_value);
			$expense_value = str_replace(",", ".", $expense_value);
		
			return $expense_value;
			
	}

	public function getStores()
	{

		$query = $this->db->query("SELECT * FROM store");

		return $query->rows ;

	}
}
