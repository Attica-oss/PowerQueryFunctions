let
function_ = (minutes as number) =>
  let
  value = if minutes >= 60
  then 
  Time.From(
      Text.From(
          Number.IntegerDivide(minutes,60)
      )&":"&Text.From(Number.Mod(minutes,60))
      )
  else Time.From("00:"&Text.From(minutes))
  in 
value as time
in
  function_
