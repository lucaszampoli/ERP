<?php
class ControllerCatalogExpense extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/expense');
		$this->document->setTitle($this->language->get('heading_title'));

    	$this->load->model('catalog/expense');

		$this->getList();
	}

	public function add() {
		$this->load->language('catalog/expense');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/expense');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm())
    {
			$this->model_catalog_expense->addExpense($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/expense');

   			 $data['language'] = $this->language;

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/expense');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm())
    {
			$this->model_catalog_expense->editExpense($this->request->get['expense_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/expense');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/expense');

		if (isset($this->request->post['selected']) && $this->validateDelete())
    {
			foreach ($this->request->post['selected'] as $expense_id)
      {
				$this->model_catalog_expense->deleteExpense($expense_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	public function repair() {
		$this->load->language('catalog/expense');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/expense');

		if ($this->validateRepair())
    {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {

    $data['language'] = $this->language;
    $data['token'] = $this->session->data['token'];
          
        if (isset($this->request->get['filter_customer'])) {
			$filter_customer = $this->request->get['filter_customer'];
		} else {
			$filter_customer = '';
		}
		
		if (isset($this->request->get['filter_month'])) {
			$filter_month = $this->request->get['filter_month'];
		} else {
			$month_today = date("m"); 
			$filter_month = $month_today;
		}

		if (isset($this->request->get['filter_year'])) {
			$filter_year = $this->request->get['filter_year'];
		} else {
			$year_today = date("Y");
			$filter_year = $year_today;
		}
    
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'expense_description';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_customer'])) {
			$url .= '&filter_customer=' . urlencode(html_entity_decode($this->request->get['filter_customer'], ENT_QUOTES, 'UTF-8'));
		}
		

		if (isset($this->request->get['filter_month'])) {
			$url .= '&filter_month=' . $this->request->get['filter_month'];
		}

		if (isset($this->request->get['filter_year'])) {
			$url .= '&filter_year=' . $this->request->get['filter_year'];
		}
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url, true)
		);
        
		$data['add'] = $this->url->link('catalog/expense/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/expense/delete', 'token=' . $this->session->data['token'] . $url, true);
		$data['repair'] = $this->url->link('catalog/expense/repair', 'token=' . $this->session->data['token'] . $url, true);
        
		$data['categories'] = array();

		$filter_data = array(
		    'filter_customer'	 => $filter_customer,
			'filter_month'	     => $filter_month,
			'filter_year'	     => $filter_year,
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);
		
		$data['stores'] = $this->model_catalog_expense->getStores();

		$expense_total = $this->model_catalog_expense->getTotalExpense($filter_data);

		$results = $this->model_catalog_expense->getExpenses($filter_data);

		foreach ($results as $result) {
			
			$expense_store = $this->model_catalog_expense->getExpenseStore($result['expense_id']);
			$expense_cost_center = $this->model_catalog_expense->getExpenseCostCenter($result['expense_id']);
			
			$data['expenses'][] = array(
				'expense_id' => $result['expense_id'],
			    'store_id' => $result['store_id'],
				'expense_description'        => $result['expense_description'],
			    'date_purchase'        => $result['date_purchase'],
			    'date_payment'        => $result['date_payment'],
				'active'  => $result['active'],
			    'paid'  => $result['paid'],
				'expense_value'  => $result['expense_value'],
				'loja' => $expense_store['name'],
			    'cost_center' => $expense_cost_center['name'],
				'edit'        => $this->url->link('catalog/expense/edit', 'token=' . $this->session->data['token'] . '&expense_id=' . $result['expense_id'] . $url, true),
				'delete'      => $this->url->link('catalog/expense/delete', 'token=' . $this->session->data['token'] . '&expense_id=' . $result['expense_id'] . $url, true)
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_rebuild'] = $this->language->get('button_rebuild');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . '&sort=expense_description' . $url, true);
		$data['sort_sort_order'] = $this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . '&sort=active' . $url, true);
		
		$url = '';
	
		if (isset($this->request->get['filter_customer'])) {
			$url .= '&filter_customer=' . urlencode(html_entity_decode($this->request->get['filter_customer'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_month'])) {
			$url .= '&filter_month=' . $this->request->get['filter_month'];
		}

		if (isset($this->request->get['filter_year'])) {
			$url .= '&filter_year=' . $this->request->get['filter_year'];
		}
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}		

		$pagination = new Pagination();
		$pagination->total = $expense_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($expense_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($expense_total - $this->config->get('config_limit_admin'))) ? $expense_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $expense_total, ceil($expense_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['filter_month'] = $filter_month;
		$data['filter_year'] = $filter_year;
		$data['filter_customer'] = $filter_customer;
   

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/expense_list', $data));
	}

	protected function getForm() {

    $this->load->model('catalog/expense');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['category_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
		$data['entry_keyword'] = $this->language->get('entry_keyword');
		$data['entry_parent'] = $this->language->get('entry_parent');
		$data['entry_filter'] = $this->language->get('entry_filter');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_top'] = $this->language->get('entry_top');
		$data['entry_column'] = $this->language->get('entry_column');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_layout'] = $this->language->get('entry_layout');

		$data['help_filter'] = $this->language->get('help_filter');
		$data['help_keyword'] = $this->language->get('help_keyword');
		$data['help_top'] = $this->language->get('help_top');
		$data['help_column'] = $this->language->get('help_column');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');
		$data['tab_design'] = $this->language->get('tab_design');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = array();
		}

		if (isset($this->error['meta_title'])) {
			$data['error_meta_title'] = $this->error['meta_title'];
		} else {
			$data['error_meta_title'] = array();
		}

		if (isset($this->error['keyword'])) {
			$data['error_keyword'] = $this->error['keyword'];
		} else {
			$data['error_keyword'] = '';
		}

		if (isset($this->error['parent'])) {
			$data['error_parent'] = $this->error['parent'];
		} else {
			$data['error_parent'] = '';
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['expense_id'])) {
			$data['action'] = $this->url->link('catalog/expense/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/expense/edit', 'token=' . $this->session->data['token'] . '&expense_id=' . $this->request->get['expense_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/expense', 'token=' . $this->session->data['token'] . $url, true);

    $data['expense_info'] = array();
    
    if (isset($this->request->get['expense_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$data['expense_info'] = $this->model_catalog_expense->getExpense($this->request->get['expense_id']);
		}
		
		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('catalog/filter');

		$data['category_filters'] = array();

		$this->load->model('setting/store');

		$data['stores'] = $this->model_setting_store->getStores();

		$this->load->model('catalog/expense');

		$data['costs'] = $this->model_catalog_expense->getCosts(array());

		$data['payment_methods'] = $this->model_catalog_expense->getPaymentMethods(array());
		
		$this->load->model('catalog/manufacturer');

		$data['manufacturers'] = $this->model_catalog_manufacturer->getManufacturers(array());
		
		$this->load->model('tool/image');

		$this->load->model('design/layout');

		$data['layouts'] = $this->model_design_layout->getLayouts();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/expense_form', $data));
	}

	protected function validateForm()
  {
    if (!$this->user->hasPermission('modify', 'catalog/expense'))
    {
      $this->error['warning'] = $this->language->get('error_permission');
    }

    if ((utf8_strlen($this->request->post['expense_description']) < 2) || (utf8_strlen($this->request->post['expense_description']) > 255))
    {
      $this->error['warning'] = $this->language->get('error_name');
    }

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/expense')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	protected function validateRepair() {
		if (!$this->user->hasPermission('modify', 'catalog/expense')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	public function getFormAddPayment()
	{
		
	$this->load->model('catalog/expense');
	
	$data['expense_info'] = $this->model_catalog_expense->getExpense($this->request->get['expense_id']);
	
		$this->response->setOutput($this->load->view('catalog/add_payment', $data));
	}
	
	public function addPaid()
	{
		$this->load->model('catalog/expense');

		$data['date_payment'] = $this->request->get['date_payment'];
		$data['expense_id'] = $this->request->get['expense_id'];
        
		$id = $this->model_catalog_expense->addPaid($data);

		print $id;
	}
	
}
