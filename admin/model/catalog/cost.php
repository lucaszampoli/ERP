<?php
class ModelCatalogCost extends Model {
	public function addCost($data)
  {
		$this->db->query("INSERT INTO " . DB_PREFIX . "cost_center
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."'
                      ");

		return $this->db->getLastId();
	}

	public function editCost($cost_center_id, $data)
  {
    $this->db->query("UPDATE " . DB_PREFIX . "cost_center
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."'
                      WHERE cost_center_id = '".$cost_center_id."'
                      ");
	}

	public function getCostCenter($cost_center_id) {
		$query = $this->db->query("SELECT * FROM cost_center
                                WHERE cost_center_id ='" . (int)$cost_center_id . "'");
		return $query->row;
	}

	public function getCosts($data = array())
  {
		$sql = "SELECT * FROM cost_center ";

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

	public function getTotalCosts() {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "cost_center");

		return $query->row['total'];
	}

	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "category_to_layout
                                WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
}
