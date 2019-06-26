<?php
class ModelSettingStore extends Model {
	public function addStore($data) {
		$target = $this->modifyMask($data['target']);
		$break_even = $this->modifyMask($data['break_even']);
		$store_value = $this->modifyMask($data['store_value']);
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "store
															SET
															name = '" . $this->db->escape($data['config_name']) . "',
															target = '" . $this->db->escape($target) . "',
															break_even = '" . $this->db->escape($break_even) . "',
															store_value = '" . $this->db->escape($store_value) . "',
															cnpj = '" . $this->db->escape($data['cnpj']) . "',
															ie = '" . $this->db->escape($data['ie']) . "',
															ccm = '" . $this->db->escape($data['ccm']) . "',
															store_type_id = '" . $this->db->escape($data['type']) . "',
															brand_id = '" . $this->db->escape($data['brand']) . "',
															`url` = '" . $this->db->escape($data['config_url']) . "',
															`ssl` = '" . $this->db->escape($data['config_ssl']) . "'");

		$store_id = $this->db->getLastId();

		// Layout Route
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "layout_route WHERE store_id = '0'");

		foreach ($query->rows as $layout_route) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "layout_route SET layout_id = '" . (int)$layout_route['layout_id'] . "', route = '" . $this->db->escape($layout_route['route']) . "', store_id = '" . (int)$store_id . "'");
		}

		$this->cache->delete('store');

		return $store_id;
	}

	public function editStore($store_id, $data) {
		
		$target = $this->modifyMask($data['target']);
		$break_even = $this->modifyMask($data['break_even']);
		$store_value = $this->modifyMask($data['store_value']);
		
		$this->db->query("UPDATE " . DB_PREFIX . "store
													SET
													name = '" . $this->db->escape($data['config_name']) . "',
													target = '" . $this->db->escape($target) . "',
													break_even = '" . $this->db->escape($break_even) . "',
													store_value = '" . $this->db->escape($store_value) . "',
													cnpj = '" . $this->db->escape($data['cnpj']) . "',
													ie = '" . $this->db->escape($data['ie']) . "',
													ccm = '" . $this->db->escape($data['ccm']) . "',
													store_type_id = '" . $this->db->escape($data['type']) . "',
													brand_id = '" . $this->db->escape($data['brand']) . "',
													`url` = '" . $this->db->escape($data['config_url']) . "',
													`ssl` = '" . $this->db->escape($data['config_ssl']) . "'
													WHERE store_id = '" . (int)$store_id . "'");

		$this->cache->delete('store');
	}

	public function deleteStore($store_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "store WHERE store_id = '" . (int)$store_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "layout_route WHERE store_id = '" . (int)$store_id . "'");

		$this->cache->delete('store');
	}

	public function getStore($store_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "store WHERE store_id = '" . (int)$store_id . "'");

		return $query->row;
	}

	public function getStores($data = array()) {

			$query = $this->db->query("SELECT s.*, b.name as brand_name FROM " . DB_PREFIX . "store s
																	LEFT JOIN brand b ON b.brand_id = s.brand_id
																	ORDER BY url");

			$store_data = $query->rows;

			return $store_data;

	}

	public function getTotalStores() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "store");

		return $query->row['total'];
	}

	public function getTotalStoresByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_layout_id' AND `value` = '" . (int)$layout_id . "' AND store_id != '0'");

		return $query->row['total'];
	}

	public function getTotalStoresByLanguage($language) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_language' AND `value` = '" . $this->db->escape($language) . "' AND store_id != '0'");

		return $query->row['total'];
	}

	public function getTotalStoresByCurrency($currency) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_currency' AND `value` = '" . $this->db->escape($currency) . "' AND store_id != '0'");

		return $query->row['total'];
	}

	public function getTotalStoresByCountryId($country_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_country_id' AND `value` = '" . (int)$country_id . "' AND store_id != '0'");

		return $query->row['total'];
	}

	public function getTotalStoresByZoneId($zone_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_zone_id' AND `value` = '" . (int)$zone_id . "' AND store_id != '0'");

		return $query->row['total'];
	}

	public function getTotalStoresByCustomerGroupId($customer_group_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_customer_group_id' AND `value` = '" . (int)$customer_group_id . "' AND store_id != '0'");

		return $query->row['total'];
	}

	public function getTotalStoresByInformationId($information_id) {
		$account_query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_account_id' AND `value` = '" . (int)$information_id . "' AND store_id != '0'");

		$checkout_query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_checkout_id' AND `value` = '" . (int)$information_id . "' AND store_id != '0'");

		return ($account_query->row['total'] + $checkout_query->row['total']);
	}

	public function getTotalStoresByOrderStatusId($order_status_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "setting WHERE `key` = 'config_order_status_id' AND `value` = '" . (int)$order_status_id . "' AND store_id != '0'");

		return $query->row['total'];
	}

	public function addStorePartner($data) {
		$investiment = $this->modifyMask($data['investiment']);
		$percentage = $this->modifyMask($data['percentage']);
		 
		$this->db->query("INSERT INTO " . DB_PREFIX . "store_partner
															SET
															store_id = '" . $this->db->escape($data['store']) . "',
															user_id = '" . $this->db->escape($data['user']) . "',
															user_group_id = '" . $this->db->escape($data['group']) . "',
															investiment = '" . $this->db->escape($investiment) . "',
															percentage = '" . $this->db->escape($percentage) . "'
															");

		$store_partner_id = $this->db->getLastId();

		return $store_partner_id;
	}

	public function getStorePartnersByStoreId($store_id)
	{
		$sql = "SELECT
						sp.active,
						format(sp.investiment,2,'de_DE') as investiment,
						format(sp.percentage,2) as percentage,
					    u.user_id,
					    u.firstname,
					    u.lastname,
					    s.name as store_name,
					     sp.store_partner_id as store_partner_id,
					    ug.name as group_name,
							round(( sp.investiment/s.store_value),2)*100 as percent
					FROM store_partner sp
						JOIN user u ON u.user_id = sp.user_id
						JOIN user_group ug ON ug.user_group_id = sp.user_group_id
						JOIN store s ON s.store_id = sp.store_id
					WHERE s.store_id = '".$store_id."'
					ORDER BY store_partner_id ASC";

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getPartner($store_partner_id) {
		$query = $this->db->query("SELECT *
			                        FROM store_partner
	                                WHERE store_partner_id ='" . (int)$store_partner_id . "'");
		return $query->row;
	}

	public function editPartner($data)
  	{
  		$investiment = $this->modifyMask($data['investiment']);
		$percentage = $this->modifyMask($data['percentage']);
		
		$this->db->query("UPDATE " . DB_PREFIX . "store_partner
                      SET
                        store_id = '" . $this->db->escape($data['store']) . "',
					    user_id = '" . $this->db->escape($data['user']) . "',
						user_group_id = '" . $this->db->escape($data['group']) . "',
						investiment = '" . $this->db->escape($investiment) . "',
						percentage = '" . $this->db->escape($percentage) . "'
                       Where store_partner_id =  '" . $this->db->escape($data['store_partner_id']) . "'
                       ");

		$store_partner_id = $this->db->countAffected();

		return $store_partner_id;
	}
	
	public function getPaymentMethods() {
		$query = $this->db->query("SELECT *
			                        FROM payment_method
	                                ");
		return $query->rows;
	}
		
	public function addStoreEnsign($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "ensign
															SET
															store_id = '" . $this->db->escape($data['store']) . "',
															user_id = '" . (int)$this->user->getId() . "',
															payment_method_id = '" . $this->db->escape($data['payment_method_id']) . "',
															ensign_value = '" . $this->db->escape($data['ensign_value']) . "'
															");

		$store_ensign_id = $this->db->getLastId();

		return $store_ensign_id;
	}
	
	public function getStoreEnsignsByStoreId($store_id)
	{
		$sql = "SELECT e.*,pm.name,
		               format(e.ensign_value,2) as ensign_value							
					FROM ensign e
					JOIN store s ON s.store_id = e.store_id
					JOIN payment_method pm ON pm.payment_method_id = e.payment_method_id 
					WHERE s.store_id = '".$store_id."'
					ORDER BY store_id ASC";
		
		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getEnsign($store_ensign_id) {
		$query = $this->db->query("SELECT *
			                        FROM ensign
	                                WHERE ensign_id ='" . (int)$store_ensign_id . "'");
		return $query->row;
	}
	
	public function editEnsign($data)
  	{
		$this->db->query("UPDATE " . DB_PREFIX . "ensign
                      SET
                        store_id = '" . $this->db->escape($data['store']) . "',
						user_id = '" . (int)$this->user->getId() . "',
						payment_method_id = '" . $this->db->escape($data['payment_method_id']) . "',
						ensign_value = '" . $this->db->escape($data['ensign_value']) . "'
                       Where ensign_id =  '" . $this->db->escape($data['store_ensign_id']) . "'
                       ");

		$store_ensign_id = $this->db->countAffected();

		return $store_ensign_id;
	}
	
	public function modifyMask($value)
  {
            $value = trim($value);
			$value = str_replace(".", "", $value);
			$value = str_replace(",", ".", $value);
		
			return $value;
			
	}
}
