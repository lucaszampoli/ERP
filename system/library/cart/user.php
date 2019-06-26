<?php
namespace Cart;
class User {
	private $user_id;
	private $username;
	private $permission = array();

	public function __construct($registry) {
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');

		if (isset($this->session->data['user_id'])) {
			$user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user WHERE user_id = '" . (int)$this->session->data['user_id'] . "' AND status = '1'");

			if ($user_query->num_rows) {
				$this->user_id = $user_query->row['user_id'];
				$this->username = $user_query->row['username'];
				$this->user_group_id = $user_query->row['user_group_id'];

				$this->db->query("UPDATE " . DB_PREFIX . "user SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE user_id = '" . (int)$this->session->data['user_id'] . "'");

				$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");

				$permissions = json_decode($user_group_query->row['permission'], true);

				if (is_array($permissions)) {
					foreach ($permissions as $key => $value) {
						$this->permission[$key] = $value;
					}
				}
				
				$this->setAccessLog($registry);
				
			} else {
				$this->logout();
			}
		}
	}

	public function login($username, $password) {
		$user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user WHERE username = '" . $this->db->escape($username) . "' AND (password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape(htmlspecialchars($password, ENT_QUOTES)) . "'))))) OR password = '" . $this->db->escape(md5($password)) . "') AND status = '1'");

		if ($user_query->num_rows) {
			$this->session->data['user_id'] = $user_query->row['user_id'];

			$this->user_id = $user_query->row['user_id'];
			$this->username = $user_query->row['username'];
			$this->user_group_id = $user_query->row['user_group_id'];

			$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");

			$permissions = json_decode($user_group_query->row['permission'], true);

			if (is_array($permissions)) {
				foreach ($permissions as $key => $value) {
					$this->permission[$key] = $value;
				}
			}

			return true;
		} else {
			return false;
		}
	}

	public function logout() {
		unset($this->session->data['user_id']);

		$this->user_id = '';
		$this->username = '';
	}

	public function hasPermission($key, $value) {
		if (isset($this->permission[$key])) {
			return in_array($value, $this->permission[$key]);
		} else {
			return false;
		}
	}

	public function isLogged() {
		return $this->user_id;
	}

	public function getId() {
		return $this->user_id;
	}

	public function getUserName() {
		return $this->username;
	}

	public function getGroupId() {
		return $this->user_group_id;
	}
	
  	public function setAccessLog($registry)
  	{	
  		if( isset($this->session->data['user_id']) )
  		{
  			$remote_addr = isset($registry->get('request')->server['REMOTE_ADDR']) ? $registry->get('request')->server['REMOTE_ADDR'] : '';
  			$http_referer = isset($registry->get('request')->server['HTTP_REFERER']) ? $registry->get('request')->server['HTTP_REFERER'] : '';
  			$http_host = isset($registry->get('request')->server['HTTP_HOST']) ? $registry->get('request')->server['HTTP_HOST'] : '';
  			$request_uri = isset($registry->get('request')->server['REQUEST_URI']) ? $registry->get('request')->server['REQUEST_URI'] : '';
  			$query_string = isset($registry->get('request')->server['QUERY_STRING']) ? $registry->get('request')->server['QUERY_STRING'] : '';
  			$route = isset($registry->get('request')->get['route']) ? $registry->get('request')->get['route']: '';
  			$request_method = isset($registry->get('request')->server['REQUEST_METHOD']) ? $registry->get('request')->server['REQUEST_METHOD'] : '';
  			$request_value = isset($registry->get('request')->request) ? json_encode($registry->get('request')->request) : '';
  			
  			try
  			{
  				$query = $this->db->query("INSERT INTO access_log_admin
										(
											user_id,
											remote_addr,
											http_referer,
											http_host,
											request_uri,
											query_string,
											route,
											request_method,
											request_value
										)
										VALUES
									    (
										'".$this->session->data['user_id']."',
										'".$this->db->escape($remote_addr)."',
										'".$this->db->escape($http_referer)."',
										'".$this->db->escape($http_host)."',
										'".$this->db->escape($request_uri)."',
										'".$this->db->escape($query_string)."',
										'".$this->db->escape($route)."',
										'".$this->db->escape($request_method)."',
										'".$this->db->escape($request_value)."'
										)");
  				
  			} catch (Exception $e) {
  				
  			}

  		}
  	}
}
