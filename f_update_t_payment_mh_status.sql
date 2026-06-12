CREATE OR REPLACE FUNCTION f_update_t_payment_mh_status(
    in_group_order_id   VARCHAR,
    in_is_paid          BOOLEAN,
    in_status           VARCHAR,
    in_payment_no       VARCHAR,
    in_approval_code    VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE t_payment_mh tpht
    SET is_paid      = in_is_paid,
        status       = in_status,
        payment_no   = in_payment_no,
        approval_code = in_approval_code,
        modified_by  = 'SYSTEM',
        modified_on  = now()
    WHERE tpht.group_order_id = in_group_order_id;
END;
$$;
