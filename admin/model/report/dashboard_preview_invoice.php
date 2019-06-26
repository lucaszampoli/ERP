<?php
class ModelReportDashboardPreviewInvoice extends Model {
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
	
	public function getPreviewInvoiceValue($data = array()) {
		$sql = "SELECT s.name as loja,  pi.preview_invoice_value, pi.date_payment, pi.date_receiving_payment, pi.customer_attended FROM " . DB_PREFIX . "preview_invoice pi 
		                             JOIN store s ON s.store_id = pi.store_id 
		                             WHERE 1";
        
	    if (!empty($data['filter_customer'])) {
			$sql .= " AND pi.store_id = '" . $this->db->escape($data['filter_customer']) . "'";
		}
		
		if (!empty($data['filter_month'])) {
			$sql .= " AND MONTH(pi.date_payment) = '" . $this->db->escape((int)$data['filter_month']) . "'";
		}

		if (!empty($data['filter_year'])) {
			$sql .= " AND YEAR(pi.date_payment) = '" . $this->db->escape($data['filter_year']) . "'";
		}
        
		$sql .= " ORDER BY pi.date_payment ASC";

		$query = $this->db->query($sql);

		return $query->rows;
	}	


	public function getTotalValueByDayOfMonth($i, $filter_month, $filter_year, $filter_customer) 
	{
		$sql = "SELECT COALESCE(SUM(i.invoice_value),0) AS total  
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
	
	public function getTotalPreviewValueByDayOfMonth($i, $filter_month, $filter_year, $filter_customer) 
	{
		$sql = "SELECT COALESCE(SUM(pi.preview_invoice_value),0) AS total_preview
		                FROM preview_invoice pi 
						WHERE 1 AND DAY(pi.date_payment) = '".(int)$i."' 
                        AND MONTH(pi.date_payment) = '".(int)$filter_month."' 
                        AND YEAR(pi.date_payment) = '".$filter_year."'";
	     
		if (!empty($filter_customer)) {
			$sql .= " AND pi.store_id = '" . $this->db->escape($filter_customer) . "'";
		}

		$query = $this->db->query($sql);
		
		return $query->row;
	}
}