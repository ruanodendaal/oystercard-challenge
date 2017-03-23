### Class design approach

| **Objects** | **Purpose**         | **Messages**
|-------------|-------------------|--------------|
| Oystercard  | balance           | initialize   |
|             | journey history   | top_up       |
|             |                   | touch_in     |
|             |                   |touch_out     |
|             |                   |in_journey?   |
|             |                   |low_balance   |
|             |                   |exceeds_limit |
|             |                   |deduct        |
|             |                   |log_journey   |
| Station     | name              |              |
|             | zone              | initialize   |
| Journey     |                   |initialize    |
|             |                   |start         |
|             |                   |end_journey   |
|             |                   |complete?     |
| JourneyLog  |                   |start         |
|             |                   |end           |
|             |                   |end           |


|             |                   |penalty_charge |
| Fare        |                   |fare_cost      |
|             |                   |minimum_amount |
|             |                   |penalty_charge |
|             |                   |total_cost     |
