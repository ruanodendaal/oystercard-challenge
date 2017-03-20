### Class design approach

| **Objects** | **Messages**        |
|-------------|---------------------|
| Oystercard  | balance             |
|             | top_up              |
|             | maximum_balance     |
|             | deduct              |
| Fare        | fare_cost           |
|             | minimum_amount      |
|             | penalty_charge      |
|             | total_journey_amount|
| Card        | touch_in            |
|             | touch_out           |
| Journey     | in_journey?         |
|             | start               |
|             | end                 |
|             | history             |
