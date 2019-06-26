<?php
class ModelCatalogStoreType extends Model {
	public function addType($data)
  {
		$this->db->query("INSERT INTO " . DB_PREFIX . "store_type
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."'
                      ");

		return $this->db->getLastId();
	}

	public function editType($type_id, $data)
  {
    $this->db->query("UPDATE " . DB_PREFIX . "store_type
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."'
                      WHERE store_type_id = '".$type_id."'
                      ");
	}

	public function getType($type_id) {
		$query = $this->db->query("SELECT * FROM store_type
                                WHERE store_type_id ='" . (int)$type_id . "'");
		return $query->row;
	}

	public function getTypes($data = array())
  {
		$sql = "SELECT * FROM store_type ";

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

	public function getTotalTypes() {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "store_type");

		return $query->row['total'];
	}

	public function getTypesList() {
		$query = $this->db->query("SELECT *
																FROM " . DB_PREFIX . "store_type
																WHERE active = 1");

		return $query->rows;
	}

}
