CREATE OR REPLACE FUNCTION f_get_ordergroup(
    in_group_order_id VARCHAR
)
RETURNS TABLE (
    group_order_id  VARCHAR,
    created_on      TIMESTAMP,
    store_id        VARCHAR,
    order_id        VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT tgo.group_order_id,
           tgo.created_on,
           tgo.store_id,
           toh.order_id
    FROM t_group_order tgo
    JOIN t_order_he toh ON tgo.group_order_id = toh.group_order_id
    WHERE tgo.group_order_id = in_group_order_id;
END;
$$;
