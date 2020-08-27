// Copyright (c) 2020, Frappe Technologies Pvt. Ltd. and contributors
// Developed for Tloutle Holdings (Pty) Ltd by Ramoletane Lekhanya
// For license information, please see license.txt
/* eslint-disable */

frappe.query_reports["Employee Leave Statement"] = {
	"filters": [
		{
			"fieldname":"from_date",
			"label": __("From Date"),
			"fieldtype": "Date",
			"default": frappe.datetime.add_months(frappe.datetime.get_today(), -1),
			"width": "60px"
		},
		{
			"fieldname":"to_date",
			"label": __("To Date"),
			"fieldtype": "Date",
			"default": frappe.datetime.get_today(),
			"width": "60px"
		},
		{
			"fieldname":"leave_type",
			"label": __("Leave Type"),
			"fieldtype": "Link",
			"options": "Leave Type"
		},
		{
			"fieldname":"employee",
			"label": __("Employee"),
			"fieldtype": "Link",
			"options": "Employee",
			"reqd": 1
		}
	]
};
