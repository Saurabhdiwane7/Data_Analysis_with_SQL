/* #Q = Show patient_id, weight, height, isObese from the patients table.
Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30.
weight is in units kg.
height is in units cm. */

select
patient_id,
weight,
height,
(case 
when weight/(power(height/100.0,2))>=30 then 
      1
      else
      0
      end) isobese
from patients