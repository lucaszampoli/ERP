<?php
class ModelReportDashboardDre extends Model {
	public function getValuesDre($data = array()) {
		$sql = "SELECT 
					    pi.date_payment,
					    s.store_id,
					    s.name AS store,
					    COALESCE(pi.preview_invoice_value, 0) AS preview_invoice_value,
					    COALESCE((SELECT 
					                    COALESCE(SUM(i.invoice_value), 0)
					                FROM
					                    invoice i
					                WHERE
					                    DATE(i.date_receiving_payment) = DATE(pi.date_payment) AND s.store_id = i.store_id
					                GROUP BY i.date_receiving_payment),
					            0) AS invoice,
					    COALESCE((SELECT 
					                    COALESCE(SUM(e.expense_value), 0)
					                FROM
					                    expense e
					                WHERE
					                    DATE(e.date_purchase) = DATE(pi.date_payment) AND s.store_id = e.store_id
					                GROUP BY e.date_purchase),
					            0) AS expense,   
					    ((COALESCE((SELECT 
                    COALESCE(SUM(i.invoice_value), 0)
					                FROM
					                    invoice i
					                WHERE
					                    DATE(i.date_receiving_payment) = DATE(pi.date_payment)
					                        AND s.store_id = i.store_id
					                GROUP BY i.date_receiving_payment),
					                            0) + COALESCE(pi.preview_invoice_value, 0))  -
						    COALESCE((SELECT 
						                    COALESCE(SUM(e.expense_value), 0)
						                FROM
						                    expense e
						                WHERE
						                    DATE(e.date_purchase) = DATE(pi.date_payment)
						                        AND s.store_id = e.store_id
						                GROUP BY e.date_purchase),
						            0)) AS balance_value 
					FROM
					    preview_invoice pi
					        JOIN
					    store s ON s.store_id = pi.store_id
					        LEFT JOIN
					    invoice i ON i.store_id = s.store_id
					        LEFT JOIN
					    expense e ON e.store_id = s.store_id
					        LEFT JOIN
					    payment_method pm ON pm.payment_method_id = i.payment_method_id
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
		
        $sql .= " GROUP BY 1,2";
        
		$sql .= " ORDER BY pi.date_payment ASC";

		$query = $this->db->query($sql);

		return $query->rows;
	}	

	public function getStores()
	{

		$query = $this->db->query("SELECT * FROM store");

		return $query->rows ;

	}
	
	/*public function getExpenseValue($data = array()) {
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
	}*/


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
	
	
	public function getInvoiceDetailByStoreId($filter) 
	{
		$sql = "SELECT pm.payment_method_id, pm.name, SUM(i.invoice_value) AS value 
		              FROM invoice i
						JOIN payment_method pm ON pm.payment_method_id = i.payment_method_id 
						WHERE i.store_id = '".$filter['store_id']."' AND DATE(i.date_receiving_payment) = '".$filter['date']."' GROUP BY 1,2";
	    
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
	
	public function getExpenseDetailByStoreId($filter) 
	{
		$sql = "SELECT pm.payment_method_id, pm.name, e.expense_description AS description, SUM(e.expense_value) AS value_expense, e.paid, e.date_payment
		              FROM expense e
		               JOIN payment_method pm ON pm.payment_method_id = e.payment_method_id 
					  WHERE e.store_id = '".$filter['store_id']."' AND DATE(e.date_purchase) = '".$filter['date']."' GROUP BY 1,2";

		$query = $this->db->query($sql);
		
		return $query->rows;
	}
}