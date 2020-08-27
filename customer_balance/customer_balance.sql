SELECT 
	party AS "Customer:Text:300",
	SUM(debit) AS "Invoiced Amount:Currency:120",
	SUM(credit) AS "Recieved Amount:Currency:120",
	SUM(debit - credit) AS "Closing Balance:Currency:120"
FROM 
	`tabGL Entry`
WHERE
	(credit > 0 OR
	 due_date < curdate()) AND
	 docstatus = 1 AND
	 party <> ''
GROUP BY
	party;
