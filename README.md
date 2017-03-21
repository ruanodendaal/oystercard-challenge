### Class design approach

| **Objects** | **Messages**        |
|-------------|---------------------|
| Oystercard  | balance             |
|             | top_up              |
|             | touch_in            |
|             | touch_out           |
|             | maximum_balance     |
|             | deduct              |
| Fare        | fare_cost           |
|             | minimum_amount      |
|             | penalty_charge      |
|             | total_journey_amount|
| Journey     | in_journey?         |
|             | entry_station       |
|             | exit_station        |
|             | journey_history     |
