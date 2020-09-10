SELECT 
	party AS "Customer:Text:300",
	SUM(debit) AS "Invoiced Amount:Currency:120",
	SUM(credit) AS "Recieved Amount:Currency:120",
	SUM(debit - credit) AS "Closing Balance:Currency:120"
FROM 
	`tabGL Entry`
WHERE
	 docstatus = 1 AND
	 party <> ''
GROUP BY
	party;
