<?php
class ModelCatalogPaymentMethod extends Model {
	public function addPaymentMethod($data)
  {
		$this->db->query("INSERT INTO " . DB_PREFIX . "payment_method
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."',
                        days_to_payment = '".$data['days_to_payment']."'
                      ");

		return $this->db->getLastId();
	}

	public function editPaymentMethod($payment_method_id, $data)
  {
    $this->db->query("UPDATE " . DB_PREFIX . "payment_method
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."',
                        days_to_payment = '".$data['days_to_payment']."'
                      WHERE payment_method_id = '".$payment_method_id."'
                      ");
	}

	public function getPaymentMethod($payment_method_id) {
		$query = $this->db->query("SELECT * FROM payment_method
                                WHERE payment_method_id ='" . (int)$payment_method_id . "'");
		return $query->row;
	}

	public function getPaymentMethods($data = array())
  {
		$sql = "SELECT * FROM payment_method ";

		$sort_data = array(
			'name',
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

	public function getTotalPaymentMethod() {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "payment_method");

		return $query->row['total'];
	}

	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "category_to_layout
                                WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
}
