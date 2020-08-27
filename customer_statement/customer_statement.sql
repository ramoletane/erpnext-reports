SELECT
    c.posting_date AS "Posting Date:Date:80",
    c.voucher_no AS "Voucher No:Text:150",
    c.debit AS "Amount Invoiced:Currency:120",
    c.credit AS "Payment Recieved:Currency:120",
    c.due AS "Amount Due:Currency:120",
    c.remarks as "Remarks:Text:360"
FROM
    (SELECT
	posting_date,
	voucher_no,
    docstatus,
	debit,
	credit,
	SUM(debit - credit) OVER(ORDER BY posting_date,voucher_no ASC) AS due,
	remarks,
	party
    FROM
        (
            (SELECT
                posting_date,
                voucher_no,
                SUM(debit) AS debit,
                SUM(credit) AS credit,
                remarks,
                party
            FROM
                `tabGL Entry`
            WHERE
                company=%(company)s AND
                party=%(party)s
            GROUP BY
                posting_date,voucher_no
            ) As a
            JOIN
            (SELECT
                name,
                docstatus
            FROM
                `tabSales Invoice` 
            WHERE
                docstatus = 1
            UNION 
            SELECT
                name,
                docstatus
            FROM
                `tabPayment Entry`
            WHERE docstatus = 1
	        ) AS b
            ON
                a.voucher_no = b.name
            )
        ) AS c
WHERE
    c.posting_date BETWEEN %(from_date)s AND %(to_date)s
ORDER BY
    c.posting_date,c.voucher_no ASC;
