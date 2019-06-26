<?php
class ModelCatalogBrand extends Model {
	public function addBrand($data)
  {
		$this->db->query("INSERT INTO " . DB_PREFIX . "brand
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."'
                      ");

		return $this->db->getLastId();
	}

	public function editBrand($brand_id, $data)
  {
    $this->db->query("UPDATE " . DB_PREFIX . "brand
                      SET
                        name = '".$data['name']."',
                        active = '".$data['status']."'
                      WHERE brand_id = '".$brand_id."'
                      ");
	}

	public function getBrand($brand_id) {
		$query = $this->db->query("SELECT * FROM brand
                                WHERE brand_id ='" . (int)$brand_id . "'");
		return $query->row;
	}

	public function getBrands($data = array())
  {
		$sql = "SELECT * FROM brand ";

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

	public function getTotalBrands() {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "brand");

		return $query->row['total'];
	}

	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total
                                FROM " . DB_PREFIX . "category_to_layout
                                WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}

	public function getBrandsList() {
		$query = $this->db->query("SELECT *
																FROM " . DB_PREFIX . "brand
																WHERE active = 1");

		return $query->rows;
	}
}
