### Class design approach

| **Objects** | **Messages**        |
|-------------|---------------------|
| Oystercard  | money               |
|             | add_money           |
|             | money_limit         |
|             | deduct_money        |
| Fare        | fare_cost           |
|             | minimum_amount      |
|             | penalty_charge      |
|             | total_journey_amount|
| Card        | touch_in            |
|             | touch_out           |
| Journey     | complete?           |
|             | start               |
|             | end                 |
|             | history             |
