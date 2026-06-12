CREATE OR REPLACE FUNCTION f_get_t_payment_he_group_order_id(
    in_group_order_id VARCHAR
)
RETURNS TABLE (
    group_order_id  VARCHAR,
    payment_no      VARCHAR,
    status          VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT tpht.group_order_id,
           tpht.payment_no,
           tpht.status
    FROM t_payment_mh tpht
    WHERE tpht.group_order_id = in_group_order_id;
END;
$$;
