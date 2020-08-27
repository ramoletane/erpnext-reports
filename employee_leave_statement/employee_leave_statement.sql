SELECT 
    from_date  AS "From Date:Date:80",
    to_date AS "To Date:Date:80",
    transaction_type AS "Transaction Type:Text:150",
    transaction_name AS "Transaction Name:Text:150",
    leave_expired AS "Expired Leave:Float:120",
    leave_forward AS "Leave C/F:Float:120",
    leave_taken AS "Taken Leave:Float:120",
    leave_accrued AS "Accrued Leave:Float:120",
    leave_balance AS "Leave Balance:Float:120"
FROM
    (SELECT 
        from_date,
        to_date,
        transaction_type,
        transaction_name,
        leave_taken,
        leave_expired,
        leave_accrued,
        leave_forward,
        SUM(leaves) OVER(ORDER BY from_date,transaction_type) AS leave_balance
    FROM
        (SELECT 
            from_date,
            to_date,
            transaction_type,
            transaction_name,
            SUM(IF(leaves < 0 && is_expired = 0, leaves, 0)) AS leave_taken,
            SUM(IF(leaves < 0 && is_expired = 1, leaves, 0)) AS leave_expired,
            SUM(IF(leaves > 0 && is_carry_forward = 0, leaves, 0)) AS leave_accrued,
            SUM(IF(leaves > 0 && is_carry_forward = 1, leaves, 0)) AS leave_forward,
            SUM(leaves) AS leaves
        FROM 
            `tabLeave Ledger Entry`
        WHERE 
            leave_type=%(leave_type)s AND
            employee=%(employee)s AND
            docstatus=1
        GROUP BY 
            from_date,transaction_type) a
    ORDER BY
        from_date) b
WHERE
    b.from_date BETWEEN %(from_date)s AND %(to_date)s;
