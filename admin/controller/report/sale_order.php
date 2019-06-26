<?php
class ControllerReportSaleOrder extends Controller {
	public function index() {
		$this->load->language('report/sale_order');

		$this->document->setTitle($this->language->get('heading_title'));
        
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


		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('report/sale_order', 'token=' . $this->session->data['token'] . $url, true)
		);

		$this->load->model('report/dashboard');

		$data['invoices'] = array();
        $data['expenses'] = array();
        $data['total_invoice'] = 0;
        $data['total_expense'] = 0;
        
		$filter_data = array(
		    'filter_customer'	 => $filter_customer,
			'filter_month'	     => $filter_month,
			'filter_year'	     => $filter_year,
			
		);

		$data['stores'] = $this->model_report_dashboard->getStores();
		
		$results_invoices = $this->model_report_dashboard->getInvoiceValue($filter_data);
 
		foreach ($results_invoices as $result) {
			$data['invoices'][] = array(
			    'loja'                  => $result['loja'],
				'invoice_value'         => $result['invoice_value'],
				'date_payment'          =>  date($this->language->get('date_format_short'), strtotime($result['date_payment'])),
			    'date_receiving_payment'=>  date($this->language->get('date_format_short'), strtotime($result['date_receiving_payment'])),
				'customer_attended'     => $result['customer_attended']
				
			);
			 $data['total_invoice'] += ( $result['invoice_value'] );
		}
		
		 $results_expenses = $this->model_report_dashboard->getExpenseValue($filter_data);
		  
	     foreach ($results_expenses as $result) {
			$data['expenses'][] = array(
			    'loja'         => $result['loja'],
				'expense_value'=> $result['expense_value'],
				'date_purchase'=>  date($this->language->get('date_format_short'), strtotime($result['date_purchase'])),
			    'date_payment' =>  date($this->language->get('date_format_short'), strtotime($result['date_payment'])),
				'cost_center_name'=> $result['cost_center_name']
			);
			 $data['total_expense'] += ( $result['expense_value'] );
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['button_filter'] = $this->language->get('button_filter');

		$data['token'] = $this->session->data['token'];


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

		$data['filter_month'] = $filter_month;
		$data['filter_year'] = $filter_year;
		$data['filter_customer'] = $filter_customer;

		$json_weeks = array();
		$json_values= array();
		$json_customers= array();
		$json_ticket= array();
		$days_of_month = cal_days_in_month(CAL_GREGORIAN,$filter_month,$filter_year);
		
        for ($i = $days_of_month; $i >= 1; $i--) 
        {    
        	   
        	$total_value_days_of_month_year = $this->model_report_dashboard->getTotalValueByDayOfMonth($i, $filter_month, $filter_year, $filter_customer);
			array_unshift($json_weeks,$i);
			array_unshift($json_values,  $total_value_days_of_month_year['total']);
			array_unshift($json_customers,  $total_value_days_of_month_year['customers']);
			array_unshift($json_ticket,  $total_value_days_of_month_year['ticket']);
			
        }
		
		array_unshift($json_values,  'Total vendido (R$)');
		array_unshift($json_customers, 'Total de Clientes Atendidos ');
		array_unshift($json_ticket,  'Ticket Médio (R$)');
		
			
		$data['json_weeks'] = json_encode($json_weeks);
		
		$data['json_values'] = json_encode($json_values);
		$data['json_customers'] = json_encode($json_customers);
		$data['json_ticket'] = json_encode($json_ticket);
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('report/sale_order', $data));
	}
}