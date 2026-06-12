CREATE OR REPLACE FUNCTION f_list_t_payment_mh_by_group_order_id(
    in_group_order_id VARCHAR
)
RETURNS TABLE (
    group_order_id      VARCHAR,
    is_paid             BOOLEAN,
    payment_code        VARCHAR,
    link                VARCHAR,
    payment_gateway_name VARCHAR,
    member_id           VARCHAR,
    status              VARCHAR,
    payment_gateway_id  VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT tpht.group_order_id,
           tpht.is_paid,
           tpht.payment_code,
           mpg.link,
           mpg.payment_gateway_name,
           tgo.member_id,
           tpht.status,
           mpg.payment_gateway_id
    FROM t_payment_mh tpht
    JOIN s_payment_type spt
        ON tpht.payment_code = spt.payment_type_code
       AND spt.status = true
       AND spt.company_group = 'HSE'
    JOIN t_group_order tgo
        ON tgo.group_order_id = tpht.group_order_id
    JOIN m_payment_terminal mpt
        ON spt.payment_terminal_id = mpt.payment_terminal_id
       AND mpt.status = true
       AND mpt.company_group = 'HSE'
    JOIN m_payment_gateway mpg
        ON mpt.payment_gateway_id = mpg.payment_gateway_id
    WHERE tpht.group_order_id = in_group_order_id;
END;
$$;
