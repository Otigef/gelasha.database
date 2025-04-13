customer ——< customer_address >—— address ——< country
   |
   |——< cust_order ——< order_line >—— book ——< book_author >—— author
                    |
              shipping_method
                    |
              order_status ——< order_history

book —— publisher
     —— book_language