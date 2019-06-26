<?php
class ModelReportDashboard extends Model {
	public function getInvoiceValue($data = array()) {
		$sql = "SELECT s.name as loja,  i.invoice_value, i.date_payment, i.date_receiving_payment, i.customer_attended FROM " . DB_PREFIX . "invoice i 
		                             JOIN store s ON s.store_id = i.store_id 
		                             WHERE 1";
        
	    if (!empty($data['filter_customer'])) {
			$sql .= " AND i.store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(i.date_receiving_payment) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(i.date_receiving_payment) = '" . $this->db->escape($data['filter_year']) . "'";
		}
        
		$sql .= " ORDER BY i.date_receiving_payment ASC";

		$query = $this->db->query($sql);

		return $query->rows;
	}	

	public function getStores()
	{

		$query = $this->db->query("SELECT * FROM store");

		return $query->rows ;

	}
	
	public function getExpenseValue($data = array()) {
		$sql = "SELECT s.name as loja, cc.name as cost_center_name, e.expense_value, e.date_purchase, e.date_payment FROM " . DB_PREFIX . "expense e
		                             JOIN store s ON s.store_id = e.store_id 
		                             JOIN cost_center cc ON cc.cost_center_id = e.cost_center_id
		                             WHERE 1";
        
	    if (!empty($data['filter_customer'])) {
			$sql .= " AND e.store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(e.date_purchase) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(e.date_purchase) = '" . $this->db->escape($data['filter_year']) . "'";
		}
        
		$sql .= " ORDER BY e.date_purchase ASC";

		$query = $this->db->query($sql);

		return $query->rows;
	}


	public function getTotalValueByDayOfMonth($i, $filter_month, $filter_year, $filter_customer) 
	{
		$sql = "SELECT COALESCE(SUM(i.invoice_value),0) AS total,  COALESCE(SUM(i.customer_attended),0) AS customers, COALESCE((i.invoice_value / i.customer_attended),0) as ticket
		                FROM invoice i 
						WHERE 1 AND DAY(i.date_receiving_payment) = '".(int)$i."'  
                        AND MONTH(i.date_receiving_payment) = '".(int)$filter_month."' 
                        AND YEAR(i.date_receiving_payment) = '".$filter_year."'";
	     
		if (!empty($filter_customer)) {
			$sql .= " AND i.store_id = '" . $this->db->escape($filter_customer) . "'";
		}
		
		$query = $this->db->query($sql);
		
		return $query->row;
	}
}